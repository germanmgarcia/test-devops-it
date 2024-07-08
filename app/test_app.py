import json
from app import app

def test_home():
    with app.test_client() as client:
        response = client.get('/')
        data = json.loads(response.data)
        assert response.status_code == 200
        assert data['message'] == 'Hello, World!'

def test_add():
    with app.test_client() as client:
        response = client.post('/add', json={'a': 1, 'b': 2})
        data = json.loads(response.data)
        assert response.status_code == 200
        assert data['result'] == 3

def test_subtract():
    with app.test_client() as client:
        response = client.post('/subtract', json={'a': 5, 'b': 3})
        data = json.loads(response.data)
        assert response.status_code == 200
        assert data['result'] == 2
