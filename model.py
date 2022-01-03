import hashlib
import secrets
import mysql
from flask import session, request
from mysql.connector import connect, Error


def get_con():
    conn = connect(
        host="localhost",
        user="root",
        password="qazsewsxdr12345",
        database="dbo")
    return conn


def valid_login(username, password):
    result = []
    try:
        conn = get_con()
        cursor = conn.cursor()
        pass_hash = hashlib.md5(password.encode('utf-8')).hexdigest()
        args = [username, pass_hash, 0]
        result = cursor.callproc('auth', args)

        print("Printing callproc results", result[2])
    except mysql.connector.Error as error:
        print("Failed to execute stored procedure: {}".format(error))
    except Error as e:
        print(e)
    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()
            print("MySQL connection is closed")

    if len(result) < 2:
        return None
    if result[2] > 0:
        session['username'] = username
        session['userid'] = result[2]
        session['token'] = secrets.token_hex()
    return result[2] > 0


def profile_set(data):
    try:
        conn = get_con()
        cursor = conn.cursor()
        data[6] = hashlib.md5(data[6].encode('utf-8')).hexdigest()
        args = [*data, 0]
        result = cursor.callproc('user_add', args)
        conn.commit()

        print("Printing callproc results", result[7])
    except mysql.connector.Error as error:
        print("Failed to execute stored procedure: {}".format(error))
        return None
    except Error as e:
        print(e)
        return None
    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()
            print("MySQL connection is closed")

    if len(result) < 8:
        return None
    session['userid'] = result[7]
    session['token'] = secrets.token_hex()
    return result[7] > 0


def interests_set(data):
    try:
        conn = get_con()
        cursor = conn.cursor()

        args = data.split(',')
        args = [(i, 0) for i in args]
        #query = "call interests_set(%s, %s)"
        #records = cursor.executemany(query, args)
        ids = []
        for value in args:
            result = cursor.callproc('interests_set', value)
            ids.append(result[1])

        conn.commit()
    except mysql.connector.Error as error:
        print("Failed to execute stored procedure: {}".format(error))
    except Error as e:
        print(e)
    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()
            print("MySQL connection is closed")

    return ids


def user_interests_set(data):
    try:
        conn = get_con()
        cursor = conn.cursor()

        args = [(session.get('userid'), i) for i in data]
        query = "call user_interests_set(%s, %s)"
        cursor.executemany(query, args)
        conn.commit()
    except mysql.connector.Error as error:
        print("Failed to execute stored procedure: {}".format(error))
    except Error as e:
        print(e)
    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()
            print("MySQL connection is closed")
    return True


def friends_set(friendid):
    try:
        conn = get_con()
        cursor = conn.cursor()

        args = [session.get('userid'), friendid]
        cursor.callproc("friends_set", args)
        conn.commit()
    except mysql.connector.Error as error:
        print("Failed to execute stored procedure: {}".format(error))
    except Error as e:
        print(e)
    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()
            print("MySQL connection is closed")
    return True


def friends_del(friendid):
    try:
        conn = get_con()
        cursor = conn.cursor()

        args = [session.get('userid'), friendid]
        cursor.callproc("friends_del", args)
        conn.commit()
    except mysql.connector.Error as error:
        print("Failed to execute stored procedure: {}".format(error))
    except Error as e:
        print(e)
    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()
            print("MySQL connection is closed")
    return True


def cities_list():
    try:
        conn = get_con()
        cursor = conn.cursor()
        cursor.callproc('cities_list')

        for result in cursor.stored_results():
            records = result.fetchall()
    except mysql.connector.Error as error:
        print("Failed to execute stored procedure: {}".format(error))
    except Error as e:
        print(e)
    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()
            print("MySQL connection is closed")

    return records


def users_list(page, items_per_page):
    try:
        conn = get_con()
        cursor = conn.cursor()
        args = [session.get("userid"), page, items_per_page, 0]
        res = cursor.callproc('users_list', args)

        for result in cursor.stored_results():
            records = result.fetchall()
    except mysql.connector.Error as error:
        print("Failed to execute stored procedure: {}".format(error))
    except Error as e:
        print(e)
    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()
            print("MySQL connection is closed")

    return records, res[3]


def profile_get(userid):
    try:
        conn = get_con()
        cursor = conn.cursor()
        args = [userid]
        cursor.callproc('user_get', args)

        for result in cursor.stored_results():
            records = result.fetchall()
    except mysql.connector.Error as error:
        print("Failed to execute stored procedure: {}".format(error))
    except Error as e:
        print(e)
    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()
            print("MySQL connection is closed")

    return records[0]
