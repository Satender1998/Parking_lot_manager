from fastapi import FastAPI
from pydantic import BaseModel, Field
import mysql.connector

# Create a Fastapi app
app = FastAPI()

class User(BaseModel):
    name: str
    email: str
    password: str
    role: str



# connection to the mysql database
cnx = mysql.connector.connect(
    user = 'root',
    password = '8860465112',
    host = '127.0.0.1',
    database = 'satender'
)

# cursor to execute quesies
# cursor = cnx.cursor()

#  fetch all user data
@app.get('/users')
async def get_users():
    cursor = cnx.cursor()
    query = 'SELECT * FROM USER'
    cursor.execute(query)
    rows = cursor.fetchall()
    cnx.commit()
    cursor.close()
    cnx.close()
    
    print(rows)
    return rows

    # users = []
    # for row in rows:
    #     user = {
    #         'user_id': row[0],
    #         'name': row[1],
    #         'email': row[2],
    #         'password': row[3],
    #         'role': row[4]
    #     }
    #     users.append(user)

    #     # return the list of users as json
    # return {'users': users}


@app.get('/user/{user_id}')
async def single_user(user_id: int):
    cursor = cnx.cursor()
    # query = ('SELECT * FROM USER where user=%s',(user_id))
    query = f"select * from user where user_id = {user_id}"
    cursor.execute(query)
    rows = cursor.fetchone()
    cnx.commit()
    cursor.close()
    # cnx.close()
    return rows

#  loop replace krna hai sql likhni hai 

    # for row in rows:
    #     for j in row:
    #         if j == user_id:
    #             return row
    # return {"message":"Country not found"}

@app.post('/user')
async def add_user(user: User):
    cursor = cnx.cursor()
    add_user = 'INSERT INTO User (name, email, password, role) values (%s,%s,%s,%s)'
    data_user = (user.name, user.email, user.password, user.role)
    cursor.execute(add_user, data_user)
    cnx.commit()
    cursor.close()
    # cnx.close()
    return {"message": "User created successfully!"}

@app.delete("/user/{user_id}")
async def delete_user(user_id: int):
    try:
        cursor = cnx.cursor()
        query = f"delete from user where user_id = {user_id}"
        cursor.execute(query)
        rows = cursor.fetchone()
        cnx.commit()
        cursor.close()
        # cnx.close()
    except:
        return {"Message": "cannot delete parent one "}