import pytest
from app.main import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_greet_valid_name(client):
    response = client.get('/greet/John')
    assert response.status_code == 200
    assert response.json['message'] == 'hello John'

def test_greet_invalid_name(client):
    response = client.get('/greet/John123!@#')
    assert response.status_code == 200
    assert response.json['message'] == 'hello John'

def test_greet_empty_name(client):
    response = client.get('/greet/123!@#')
    assert response.status_code == 400
    assert 'error' in response.json

def test_update_greeting_valid(client):
    response = client.post('/greeting-word', json={'word': 'Hi'})
    assert response.status_code == 200
    
    # Check if greeting was updated
    response = client.get('/greet/John')
    assert response.status_code == 200
    assert response.json['message'] == 'Hi John'

def test_update_greeting_invalid(client):
    response = client.post('/greeting-word', json={'word': '123!@#'})
    assert response.status_code == 400
    assert 'error' in response.json

def test_update_greeting_missing_word(client):
    response = client.post('/greeting-word', json={})
    assert response.status_code == 400
    assert 'error' in response.json 