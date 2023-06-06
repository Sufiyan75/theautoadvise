from flask import Flask, render_template, request, session, redirect
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
import json
from flask_mail import Mail
import os
from werkzeug.utils import secure_filename
import math
from hashlib import md5
import random

local_server = True
with open("config.json", "r") as c:
    params = json.load(c)["params"]

app = Flask(__name__)
app.secret_key = 'super-secret-key'
app.config['UPLOAD_FOLDER'] = params['upload_location']

app.config.update(
    MAIL_SERVER = 'smtp.gmail.com',
    MAIL_PORT = '465',
    MAIL_USE_SSL = True,
    MAIL_USERNAME = params['gmail-user'],
    MAIL_PASSWORD = params['gmail-pass']
)

mail = Mail(app)

if local_server:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['local_uri']
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['prod_uri']

db = SQLAlchemy(app)

class Contacts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80))
    username = db.Column(db.String(50))
    email = db.Column(db.String(120))
    phone_num = db.Column(db.String(12))
    msg = db.Column(db.String(120))
    date = db.Column(db.String(12))
    reply = db.Column(db.String(120))
    status = db.Column(db.String(15))
    delete_status = db.Column(db.String(15))

class Posts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    sender_uname = db.Column(db.String(50)) 
    sender_name = db.Column(db.String(50))
    title = db.Column(db.String(50))
    subtitle = db.Column(db.String(30))
    slug = db.Column(db.String(30))
    content = db.Column(db.String(80))
    img_file = db.Column(db.String(12))
    date = db.Column(db.String(12))
    time = db.Column(db.String(12))
    visible = db.Column(db.String(30))

class Users(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    sender_name = db.Column(db.String(50))
    username = db.Column(db.String(50))
    email = db.Column(db.String(30))
    password = db.Column(db.String(30))
    about = db.Column(db.String(500))
    date = db.Column(db.String(12))
    time = db.Column(db.String(12))

class about_autoadvice(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    about = db.Column(db.String(500))

class Comments(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    slug = db.Column(db.String(30))
    sender_uname = db.Column(db.String(50))
    comment = db.Column(db.String(500))
    date = db.Column(db.String(12))
    time = db.Column(db.String(12))


@app.route("/")
def home():
    post2 = Posts.query.filter_by().all()
    last = math.ceil(len(post2)/int(params['rows']))
    page=request.args.get('page')
    if(not str(page).isnumeric()):
        page=1
    page=int(page)
    post2=post2[(page-1)*int(params['rows']):(page-1)*int(params['rows'])+int(params['rows'])]
    if (page == 1):
        prev = "#"
        next = "/?page=" + str(page+1)
    elif (page==last):
        prev = "/?page=" + str(page-1)
        next = "#"
    else:
        prev = "/?page=" + str(page-1)
        next = "/?page=" + str(page+1)
    
    return render_template("index.html", params=params, posthome=post2, prev=prev, next=next, pagecnt=page, lastp=last, u2=session.get('login_user'), u3=session.get('user'))

@app.route("/about")
def about():
    post = about_autoadvice.query.first()
    return render_template("about.html", params=params, about=post)

@app.route("/about_ad", methods=['GET', 'POST'])
def about_ad():
    if ('user' in session and session['user'] == params['admin_user']):
        if request.method == "POST":
            ab = request.form.get('about')
            post = about_autoadvice.query.first()
            post.about = ab
            db.session.commit()
            return redirect("/about_ad")
    post = about_autoadvice.query.first()
    return render_template("about_ad.html", params=params, about=post)

@app.route("/about_user/<string:sender_name>", methods=['GET', 'POST'])
def about_user(sender_name):
    user=Users.query.filter_by(sender_name=sender_name).first()
    return render_template("about_user.html", user=user, params=params)

@app.route("/post/<string:post_slug>", methods = ['GET'])
def post_route(post_slug):
    post = Posts.query.filter_by(slug=post_slug).first()
    cmt = Comments.query.filter_by(slug=post_slug).all()
    return render_template("post.html", params=params, posts=post, comments=cmt)

@app.route("/comment_add/<string:post_slug>", methods = ['GET', 'POST'])
def comment_add(post_slug):
    if 'login_user' in session and session['login_user'] == session.get('check_uname'):
        if request.method == "POST":
            fcmt=str(request.form.get('comment'))
            now = datetime.now()
            reg_date = now.strftime("%Y-%m-%d")
            reg_time = now.strftime("%H:%M:%S")

            cmt_add = Comments(slug=post_slug, sender_uname=session.get('login_user'), comment=fcmt, date=reg_date, time=reg_time)
            db.session.add(cmt_add)
            db.session.commit()
            post = Posts.query.filter_by(slug=post_slug).first()
            cmt = Comments.query.filter_by(slug=post_slug).all()
            return render_template("post.html", params=params, posts=post, comments=cmt)
    return redirect("/login_user")

@app.route("/contact", methods = ['GET', 'POST'])
def contact():
    err=None
    if (request.method == 'POST'):
        name = request.form.get('name')
        email = request.form.get('email')
        phone = request.form.get('phone')
        message = request.form.get('message')
        username = request.form.get('uname')
        status = "Unreaded"
        delete_status = "No"
        entry = Contacts(name=name, username=username, email=email, phone_num = phone, msg=message, date=datetime.now(), status=status, delete_status=delete_status)
        db.session.add(entry)
        db.session.commit()
        mail.send_message('New Message From ' + params['title'],
                        sender = email,
                        recipients = [params['gmail-user']],
                        body = "Message: " + message + "\n" +  "Contact No: " + phone + "\n" + "Email: " + email
                        )
        err="Message Sent"
    return render_template("contact.html", params=params, u2=session.get('login_user'), error=err)


@app.route("/dashboard", methods = ['GET', 'POST'])
def dashboard():
    msg=None
    if ('user' in session and session['user'] == params['admin_user']):
        msg="Successfully Logged In"
        post3 = Posts.query.all()
        con = Contacts.query.all()
        return render_template('dashboard.html', params=params, postdash=post3, contacts=con, msg=msg, u2=params['admin_user'])

    if request.method == 'POST':
        username = request.form.get('uname')
        userpass = request.form.get('pass')
        if(username == params['admin_user'] and userpass == params['admin_pass']):
            session['user'] = params['admin_user']
            post3 = Posts.query.all()
            con = Contacts.query.all()
            msg="Successfully Logged In"
            return render_template("dashboard.html", params=params, postdash=post3, contacts=con, msg=msg, u2=params['admin_user'])
        elif(username != params['admin_user']):
            msg="Invalid Username"
        elif(userpass != params['admin_pass']):
            msg="Invalid Password"
    return render_template("login.html", params=params, msg=msg, u2=params['admin_user'])

@app.route("/reply_contact/<string:sno>", methods=['GET', 'POST'])
def reply_contact(sno):
    con = Contacts.query.filter_by(sno=sno).first()
    if request.method == "POST":
        r = request.form.get('reply')
        post = Contacts.query.filter_by(sno=sno).first()
        post.reply = r
        post.status = "Readed"
        db.session.commit()
        msg = "Reply Sent Sucessfully"
        return render_template("reply_contact.html", params=params, contacts=con, u2=params['admin_user'], msg=msg)
    return render_template("reply_contact.html", params=params, contacts=con, u2=params['admin_user'])

@app.route("/view_contact/<string:sno>", methods=['GET', 'POST'])
def veiw_contact(sno):
    q = Contacts.query.filter_by(sno=sno).first()
    return render_template("view_contact.html", params=params, contact=q)

@app.route("/delete_contact/<string:sno>", methods=['GET', 'POST'])
def delete_contact(sno):
    q = Contacts.query.filter_by(sno=sno).first()
    q.delete_status = "Yes"
    db.session.commit()
    user = Posts.query.filter_by(sender_uname=session.get('login_user')).all()
    error="Successfully Deleted"
    a = Contacts.query.filter_by(username=session.get('login_user')).all()
    return render_template("dashboard_user.html", params=params, u2=session.get('login_user'), posts=user, error=error, contacts=a)

@app.route("/regis_user", methods=['GET', 'POST'])
def regis_user():
    if request.method == "POST":
        reg_name = request.form.get('name')
        reg_uname = request.form.get('uname')
        reg_email = request.form.get('email')
        reg_pass = str(request.form.get('pass'))
        result = md5(reg_pass.encode())
        r2=result.hexdigest()
        now = datetime.now()
        reg_date = now.strftime("%Y-%m-%d")
        reg_time = now.strftime("%H:%M:%S")

        register = Users(sender_name=reg_name, username=reg_uname, email=reg_email, password=r2, date=reg_date, time=reg_time)
        db.session.add(register)
        db.session.commit()
        return render_template("/login_user.html", params=params)

    return render_template("regis_user.html", params=params)

@app.route("/login_user", methods=['GET', 'POST'])
def login_user():
    error = None
    if request.method == 'POST':
        username = request.form.get('uname')
        userpass = str(request.form.get('pass'))
        result = md5(userpass.encode())
        r2 = result.hexdigest()
        session['check_uname'] = username

        postlogin = Users.query.filter_by(username=username).first()
        if postlogin:
            if username == postlogin.username and postlogin.password == r2:
                global p1
                p1 = postlogin.password
                session['login_user'] = postlogin.username
                v1 = session.get('login_user')
                user = Posts.query.filter_by(sender_uname=session.get('login_user')).all()
                c = Contacts.query.filter_by(username=session.get('login_user')).all()
                error = 'Successfully Logged In'
                return render_template("dashboard_user.html", params=params, u2=session.get('login_user'), posts=user, error=error, contacts=c)
            else:
                error = 'Invalid Credentials'
                return render_template("login_user.html", params=params, error=error)
        else:
            error = "Username or Password Is Invalid"
            return render_template("login_user.html", params=params, error=error)

    if 'login_user' in session and session['login_user'] == session.get('check_uname'):
        user = Posts.query.filter_by(sender_uname=session.get('login_user')).all()
        c = Contacts.query.filter_by(username=session.get('login_user')).all()
        return render_template("dashboard_user.html", params=params, posts=user, u2=session.get('login_user'), contacts=c)

    return render_template("login_user.html", params=params)


@app.route("/edit/<string:sno>", methods=['GET', 'POST'])
def edit(sno):
    if ('user' in session and session['user'] == params['admin_user']):
        if request.method == "POST":
            box_sender_uname = request.form.get('suname')
            box_sender_name = request.form.get('sname')
            box_title = request.form.get('title')
            box_tline = request.form.get('tline')
            box_slug = request.form.get('slug')
            box_content= request.form.get('content')
            box_img_file= request.form.get('img_file')
            now = datetime.now()
            box_date_str = now.strftime("%Y-%m-%d")
            box_time_str = now.strftime("%H:%M:%S")
            f = request.files['file1']
            if sno == '0':
                post = Posts(sender_uname=box_sender_uname, sender_name=box_sender_name, title=box_title, subtitle=box_tline, slug=box_slug, content=box_content, img_file=box_img_file, date=box_date_str, time=box_time_str)
                db.session.add(post)
                db.session.commit()
            else:
                post = Posts.query.filter_by(sno=sno).first()
                post = Posts.query.filter_by(sno=sno).first()
                if f.filename == "":
                    file2 = box_img_file
                else:
                    f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename)))
                    file2=f.filename
                post.sname = box_sender_name
                post.suname = box_sender_uname
                post.title = box_title
                post.slug = box_slug
                post.subtitle = box_tline
                post.content = box_content
                post.img_file = file2
                post.date = box_date_str
                post.time = box_time_str
                db.session.commit()
                return redirect('/edit/' + sno)
    post = Posts.query.filter_by(sno=sno).first()
    return render_template("edit.html", params=params, sno=sno, postedit=post, u2=session.get('login_user'))
    
@app.route("/edit_userpost/<string:sno>", methods=['GET', 'POST'])
def edit_userpost(sno):
    error=None
    if ('login_user' in session and session['login_user'] == session.get('login_user')):
        if request.method == "POST":
            box_sender_uname = request.form.get('suname')
            box_sender_name = request.form.get('sname')
            box_title = request.form.get('title')
            box_tline = request.form.get('tline')
            box_slug = request.form.get('slug')
            box_content= request.form.get('content')
            box_img_file= request.form.get('img_file')
            now = datetime.now()
            box_date_str = now.strftime("%Y-%m-%d")
            box_time_str = now.strftime("%H:%M:%S")
            f = request.files['file1']
            if sno == '0':
                f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename)))
                file2=f.filename
                post = Posts(sender_uname=session.get('login_user'), sender_name=box_sender_name, title=box_title, subtitle=box_tline, slug=box_slug, content=box_content, img_file=file2, date=box_date_str, time=box_time_str)
                db.session.add(post)
                db.session.commit()
                error = "Added New Post"
                user = Posts.query.filter_by(sender_uname=session.get('login_user')).all()
                c = Contacts.query.filter_by(username=session.get('login_user')).all()
                return render_template("dashboard_user.html", params=params, u2=session.get('login_user'), posts=user, error=error, contacts=c)
            else:
                post = Posts.query.filter_by(sno=sno).first()
                if f.filename == "":
                    file2 = box_img_file
                else:
                    f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename)))
                    file2=f.filename
                
                post.sname = box_sender_name
                post.suname = box_sender_uname
                post.title = box_title
                post.slug = box_slug
                post.subtitle = box_tline
                post.content = box_content
                post.img_file = file2
                post.date = box_date_str
                post.time = box_time_str
                db.session.commit()
                return redirect('/edit_userpost/' + sno)
    post = Posts.query.filter_by(sno=sno).first()
    return render_template("edit_userpost.html", params=params, sno=sno, postedit=post, u2=session.get('login_user'))

@app.route("/uploader", methods=['GET', 'POST'])
def uploader():
    if ('user' in session and session['user'] == params['admin_user']):
        if request.method == 'POST':
            f = request.files['file1']
            f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename)))
            return "Upload Successful"


@app.route("/newpost/<string:sno>", methods=['GET', 'POST'])
def newpost(sno):
    if ('login_user' in session and session['login_user'] == session.get('check_uname')):
        return redirect("/edit_userpost", sno)
    else:
        return render_template("/login_user.html", params=params)

@app.route("/delete/<string:sno>", methods=['GET', 'POST'])
def delete(sno):
    if ('user' in session and session['user'] == params['admin_user']):
        post5 = Posts.query.filter_by(sno=sno).first()
        db.session.delete(post5)
        db.session.commit()
    return redirect("/dashboard", u2=session.get('login_user'))

@app.route("/delete_post/<string:sno>", methods=['GET', 'POST'])
def delete_post(sno):
    if ('login_user' in session and session['login_user'] == session.get('login_user')):
        post5 = Posts.query.filter_by(sno=sno).first()
        db.session.delete(post5)
        db.session.commit()
    return redirect("/login_user")

@app.route("/edit_userprofile", methods=['GET', 'POST'])
def edit_userprofile():
    user=session.get('login_user')
    post=Users.query.filter_by(username=user).first()
    if ('login_user' in session and session['login_user'] == session.get('login_user')):
        if request.method == "POST":
            s_name=request.form.get('sname')
            u_name=request.form.get('username')
            u_email=request.form.get('email')
            u_about=request.form.get('about')
            user=session.get('login_user')
            post=Users.query.filter_by(username=user).first()
            post.sender_name=s_name
            post.username=u_name
            post.email=u_email
            post.about=u_about
            db.session.commit()
            return redirect("/edit_userprofile")
    return render_template("edit_userprofile.html", params=params, postedit=post, u2=user)

@app.route("/logout")
def logout():
    session.pop('user')
    return redirect('/')

@app.route("/logout_user")
def logout_user():
    session.pop('login_user')
    return redirect('/')

@app.route("/forgotpass", methods=['GET', 'POST'])
def forgotpass():
    error = None
    if request.method == "POST":
        foruname=request.form.get('forgotuname')
        post=Users.query.filter_by(username=foruname).first()
        if post:
            email = post.email
            session['email'] = post.email
            return render_template('forgotpass2.html', params=params, em=email)
        else:
            error="No Such Username"
    return render_template("forgotpass1.html", params=params, error=error)

@app.route("/forgotpass2", methods=['GET', 'POST'])
def forgotpass2():
    if request.method == "POST":
        email = session.get('email')
        message = "Please use this code to reset the password for the " + params['title'] + " account " + email + "."
        global code
        code = str(random.randint(100000, 999999))
        mail.send_message('Password reset code',
                    sender = params['gmail-user'],
                    recipients = [email],
                    body = message + "\n\n\n" + "Here is your code: " + code + "\n\n\n" + "Thanks," + "\n" + params['title'] + " account team"
                    )
    return render_template("forgotpass3.html", params=params, em=session.get('email'))

@app.route("/forgotpass3", methods=['GET', 'POST'])
def forgotpass3():
    error = None
    if request.method == "POST":
        c=str(request.form.get('code'))
        if c == code:
            return render_template("forgotpass4.html", params=params)
        else:
            error = "Invalid Code!"
    return render_template("forgotpass3.html", params=params, error=error, em=session.get('email'))

@app.route("/forgotpass4", methods=['GET', 'POST'])
def forgotpass4():
    error = None
    if request.method == "POST":
        npass=str(request.form.get('npass'))
        rpass=str(request.form.get('rpass'))
        
        post=Users.query.filter_by(email=session.get('email')).first()
        global epass
        epass = post.password

        result = md5(npass.encode())
        global r2
        r2=result.hexdigest()

        if npass == rpass and r2 != epass:
            post.password = r2
            db.session.commit()
            return render_template("forgotpass5.html", params=params)
        elif r2 == epass:
            error = "Password already exist!"
        else:
            error = "New Password and Reenter Password not match!"
    return render_template("forgotpass4.html", params=params, error=error)

app.run(debug=True)