from functools import wraps
from flask import Flask, render_template, request, make_response, session, url_for, redirect, flash
import model
import config

app = Flask(__name__)

app.secret_key = 'BAD_SECRET_KEY'

tech_token_list = dict()
tech_token_life = 15

'''
def token_check(token):
    # Проверка токена (времени жизни 15 минут)
    if token in tech_token_list:
        if datetime.now() - tech_token_list[token] < tech_token_life:
            return True
        else:
            del tech_token_list[token]
    return False
'''


def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        print("route login_required")
        if session.get('userid'):
            print(f'Logged in as {session["userid"]}')
        else:
            print('You are not logged in')
            return redirect(url_for('index_page'))

        # return abort(401, description="Ошибка авторизации (не совпадают данные подключения)")
        # if not token_check(token):
        #    return abort(400, description="Token error")

        return f(*args, **kwargs)

    return decorated_function


@app.errorhandler(404)
def not_found_page(error):
    return render_template('404.html', error=error), 404


@app.route("/")
def index_page():
    print("route index")
    if session.get('userid'):
        return redirect(url_for('profile_page'))

    # Доступ к параметрам
    # searchword = request.args.get('key', '')
    resp = make_response(render_template('index.html'))
    return resp


@app.route('/login', methods=['POST'])
# @login_required
def login():
    print("route login")
    if session.get('userid'):
        return redirect(url_for('profile_page'))

    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        # print(username, password)
        if model.valid_login(username, password):
            return url_for('profile_page')
        else:
            flash('Invalid username/password')
            return url_for('index_page')
    else:
        return render_template('index.html')


@app.route("/profile")
@login_required
def profile_page():
    print("route profile")
    user_res = model.profile_get(session.get('userid'))
    return render_template('profile.html', recnew=False, data=user_res, cities=None)  # , paraKey=paraValue


@app.route("/profile/new")
def profile_new_page():
    print("route profile_new_page")
    if session.get('userid'):
        return redirect(url_for('profile_page'))

    cities_res = model.cities_list()
    return render_template('profile.html', recnew=True, data=None, cities=cities_res)


@app.route("/profile/set", methods=['POST'])
def profile_set():
    print("route profile_set")
    # if session.get('userid'):
    #    return redirect(url_for('profile_page'))

    firstname = request.form['firstname']
    lastname = request.form['lastname']
    age = request.form['age']
    sex = request.form['sex']
    interests = request.form['interests']
    city = request.form['city']
    email = request.form['email']
    password = request.form['password']
    # print(firstname, lastname, age, sex, interests, city, email, password)
    data = [firstname, lastname, age, sex, city, email, password]
    if model.profile_set(data):
        userid = session.get('userid')
        print("New User", userid)
        int_ids = model.interests_set(interests)
        model.user_interests_set(int_ids)

    return url_for('profile_page')


@app.route('/logout')
def logout():
    print("route logout")
    # remove the username from the session if it's there
    session.pop('username', None)
    session.pop('userid', None)
    session.pop('token', None)
    return redirect(url_for('index_page'))


@app.route('/users')
@app.route('/users/<int:page>')
@app.route('/users/<int:page>/<string:name>/<string:surname>')
@login_required
def users_page(page=1, name=None, surname=None):
    name = name if name else ''
    surname = surname if surname else ''

    print("route users")
    # print(f'{page=} {name=} {surname=}')
    users_res, rowcount = model.users_list(page, name, surname, config.items_per_page)
    return render_template('users.html',
                           page=page,
                           users=users_res,
                           rowcount=rowcount,
                           step=max(rowcount // 10 + 1, config.items_per_page),
                           items_per_page=config.items_per_page,
                           name=name,
                           surname=surname)


@app.route('/friends/set', methods=['POST'])
@login_required
def friends_set():
    print("route friends_set")
    friendid = request.form['friendid']
    model.friends_set(friendid)
    return "friends_set"


@app.route('/friends/del', methods=['POST'])
@login_required
def friends_del():
    print("route friends_del")
    friendid = request.form['friendid']
    model.friends_del(friendid)
    return "friends_del"


if __name__ == '__main__':
    app.debug = True
    app.run(host="0.0.0.0")  # go to http://127.0.0.1:5000/ to view the page.
