import re
from flask import Flask, request, flash,redirect,render_template, url_for,session,g
import ctypes
import pandas as pd
import os
app=Flask(__name__)

import pymysql
from pymysql import Error
try:
     username=input("Enter username ")
     password=input("Enter password ")

     connection = pymysql.connect(host='localhost', user=username, password=password,db='project_jyothikaj_nittalad', charset='utf8mb4',cursorclass=pymysql.cursors.DictCursor)

     @app.route("/home")
     @app.route("/",methods=['GET','POST'])
     def home():
          return render_template("mainpage.html")

     def getadminDetails():
          cursor=connection.cursor()
          cursor.callproc('get_fte_details')
          admin_list=[]
          for row in cursor.fetchall():
               admin_list.append(row['first_name']+" "+row['last_name'])
          
          return admin_list

     @app.route("/user",methods=['GET','POST'])
     def user():
          if 'user' in session:
               g.user=session['user']
               if(g.user):
                    return redirect(url_for("sess"))

          return render_template("user.html")



     @app.route("/admin_dashy",methods=['GET','POST'])
     def admin_dashy():
          if request.method=='POST':
               cur=connection.cursor()
               adminDetails=request.form
               a_email=adminDetails['email']
               a_pass=adminDetails['password']
               cur.close

               
               session.pop('user',None)
               session['user']="Admin"
               return redirect(url_for("admin_sess"))
                    
          else:
                    
               return render_template("admin.html")

     @app.route("/admin_sess",methods=['GET','POST'])
     def admin_sess():
          g.user=None
          if 'user' in session:
               g.user=session['user']
               if(g.user):
                    return render_template("admin_dashy.html",name=session['user'])
               else:
                    
                    return redirect(url_for("home"))
          else:
               
               return redirect(url_for("home"))


     @app.route("/user_dashy",methods=['GET','POST'])
     def user_dashy():
          if request.method=='POST':
               cursor = connection.cursor()
               
               loginDetails=request.form
               username=loginDetails['u_name']
               password=loginDetails['u_password']
               cursor.callproc('get_fte_details')
               
               for row in cursor.fetchall():
                    if(row['username']==username and row['login_password']==password):
                         presentuser=row['first_name']+" "+row['last_name']
                         
                         session['user']=presentuser
                         cursor.close
                         return redirect(url_for("sess"))
               else:
                    cursor = connection.cursor()
                    cursor.callproc('get_volunteer_details')
                    for row in cursor.fetchall():
                         if(row['username']==username and row['login_password']==password):
                              
                              presentuser=row['first_name']+" "+row['last_name'] 
                              session.pop('user',None)
                              session['user']=presentuser
                              cursor.close
                              return redirect(url_for("sess"))
                         
                         
                    else:
                         if 'user' in session:
                              g.user=session['user']
                              if(g.user):
                                   return redirect(url_for("sess"))
                         ctypes.windll.user32.MessageBoxW(0, "Inavlid Credentials", "Error",1)
                         return redirect(url_for("home"))



     @app.route("/sess",methods=['GET','POST'])
     def sess():
          g.user=None
          if 'user' in session:
               g.user=session['user']
               if(g.user):
                    adminloop=getadminDetails()
                    return render_template("user_dashy.html",adminloop=adminloop,name=session['user'])
               else:
                    return render_template("user.html")
          else:
          
               return redirect(url_for('home'))


     @app.route("/manageusers",methods=['GET','POST'])
     def manageusers():
          if 'user' in session:
               g.user=session['user']
               if(g.user):
                    cursor = connection.cursor()
                    #department select for dropdown
                    adminloop=getadminDetails()
                    department_select="select * from department"
                    dept_list=[]
                    cursor.execute(department_select)
                    for row in cursor.fetchall():
                         dept_list.append(row['dept_name'])

                    #city select for dropdown
                    city_select="select * from city"
                    city_list=[]
                    cursor.execute(city_select)
                    for row in cursor.fetchall():
                         city_list.append(row['city_name'])
                    
                    #shelter home selct for dropdown
                    shelter_list=[]
                    cursor.callproc('get_shelterhome_details')
                    for row in cursor.fetchall():
                         shelter_list.append(row['shelter_name'])
                    
                    volunteers_list=[]
                    cursor.callproc('get_volunteer_details')
                    staffid_list=[]
                    for row in cursor.fetchall():
                         volunteers_list.append([row['staff_id'],row['first_name']+" "+row['last_name'],row['email_address'],row['username'],row['login_password'],row['department_name'],row['city'],row['shelter_home']])
                         staffid_list.append(row['staff_id'])               
                    df_volunteers=pd.DataFrame(volunteers_list)
                    df_volunteers.columns=['Staff ID','Name','Email','Username','Password','Department','City','Shelter home']
                    df_volunteers=df_volunteers.rename(columns={'0':'Staff ID','1':'Name','2':'Email','3':'Username','4':'Password','5':'Department','6':'City','7':'Shelter home'})

                    cursor.close
                    return render_template("manageusers.html",adminloop=adminloop,staffid_list=staffid_list,name=session['user'],tables=[df_volunteers.to_html(classes='data',header="true",index_names=False, index=False)],dept_list=dept_list,city_list=city_list,shelter_list=shelter_list)
          else:
               return redirect(url_for('home'))
          
     @app.route("/viewprofile",methods=['GET','POST'])
     def viewprofile():
          if 'user' in session:
               g.user=session['user']
               if(g.user):
                    cursor = connection.cursor()
                    username=session['user'].split(' ')
                    user_query="select * from volunteer where first_name='"+username[0]+"' and last_name='"+username[1]+"'"
                    admin_query="select * from full_time_employee where first_name='"+username[0]+"' and last_name='"+username[1]+"'"
                    cursor.execute(user_query)
                    if(cursor.rowcount>0):
                         for row in cursor.fetchall():
                              staffid=row['staff_id']
                              email=row['email_address']
                              dept=row['department_name']
                              doj=row['date_of_joining']
                    else:
                         cursor.execute(admin_query)
                         for row in cursor.fetchall():
                              staffid=row['staff_id']
                              email=row['email_address']
                              dept=row['department_name']
                              doj=row['date_of_joining']
                         
                    cursor.close 
                    return render_template("viewprofile.html",staffid=staffid,doj=doj,email=email,dept=dept,name=session['user'])
          else:
               return redirect(url_for('home'))

     @app.route("/logout",methods=['GET','POST'])
     def logout():
          session.pop('user',None)
          return render_template("mainpage.html")


     @app.route("/donations",methods=['GET','POST'])
     def donations():
          if 'user' in session:
               g.user=session['user']
               if(g.user):
                    donation_list=['One time','Monthly','Yearly']
                    cursor=connection.cursor()
                    adminloop=getadminDetails()
                    query="select * from donor"
                    cursor.execute(query)
                    donor_list=[]
                    for row in cursor.fetchall():
                         donor_list.append(row['donor_id'])
                    volunteer_list=[]
                    cursor.callproc('get_volunteer_details')
                    for row in cursor.fetchall():
                         volunteer_list.append(row['staff_id'])
                    donations_list=[]
                    cursor.callproc('get_donations')
                    for row in cursor.fetchall():
                         donations_list.append(row)
                    df=pd.DataFrame(donations_list)
                    df=df.rename(columns={'donor_id':'Donor ID','donor_name':'Donor name','amount':'Amount','donation_type':'Donation Type','email_address':'Email','referred_by':'Referred by','phone_no':'Contact No','date_of_payment':'Date of payment'})

                    connection.commit()
                    cursor.close
                    return render_template("donations.html",adminloop=adminloop,tables=[df.to_html(classes='data',header="true",index_names=False, index=False)],volunteer_list=volunteer_list,donation_list=donation_list,donor_list=donor_list,name=session['user'])
          else:
               return redirect(url_for('home')) 

     @app.route("/add_donation",methods=['GET','POST'])
     def add_donation():
          if request.method=='POST':
               donationDetails=request.form
               receiptno=donationDetails['receiptno']
               amount=donationDetails['amount']
               type=donationDetails['donationtype']
               donorid=donationDetails['donorid']
               cursor=connection.cursor()
               cursor.callproc('add_donation',args=(receiptno,amount,type,donorid))
               connection.commit()
               cursor.close
               return redirect(url_for('donations')) 
               
          pass

     @app.route("/add_donor",methods=['GET','POST'])
     def add_donor():
          if request.method=='POST':
               donorDetails=request.form
               donorname=donorDetails['donorname']
               contactno=donorDetails['contactno']
               email=donorDetails['email']
               referredby=donorDetails['referredby']
               cursor=connection.cursor()
               cursor.callproc('add_donor',args=(donorname,contactno,email,referredby))
               connection.commit()
               cursor.close
               return redirect(url_for('donations')) 
               
          pass

     @app.route("/add_user",methods=['GET','POST'])
     def add_user():
          if request.method=='POST':
               userDetails=request.form
               emp_id=userDetails['staffid']
               
               fname=userDetails['fname']
               lname=userDetails['lname']
               email=userDetails['email']
               u_name=userDetails['username']
               password=userDetails['password']
               
               age=userDetails['age']
               contactno=userDetails['contactno']
               
               department=userDetails['department']
               city=userDetails['city']
               shelter=userDetails['shelter']
               cursor = connection.cursor()   
               cursor.callproc('create_volunteer',args=(emp_id,fname,lname,age,contactno,email,u_name,password,department,city,shelter))  
               connection.commit()
               cursor.close
               return redirect(url_for('manageusers'))
               
          pass
     @app.route("/remove_user",methods=['GET','POST'])
     def remove_user():
          if request.method=='POST':
               userDetails=request.form
               emp_id=userDetails['staffid']
               cursor=connection.cursor()
               cursor.callproc('remove_volunteer',[emp_id,])
               connection.commit()
               cursor.close
               return redirect(url_for('manageusers'))
          
     @app.route("/remove_class",methods=['GET','POST'])
     def remove_class():
          if request.method=='POST':
               classDetails=request.form
               classid=classDetails['classid']
               cursor=connection.cursor()
               cursor.callproc('remove_class',[classid,])
               connection.commit()
               cursor.close
               return redirect(url_for('schedule'))

     @app.route("/update_user",methods=['GET','POST'])
     def update_user():
          if request.method=='POST':
               userDetails=request.form
               emp_id=userDetails['staffid']
               updatecolumn=userDetails['update_column']
               updatevalue=userDetails['updated_value']
               cursor=connection.cursor()
               if(updatecolumn=="email_address"):
                    cursor.callproc('update_volunteer_email',args=(emp_id,updatevalue))
               else:
                    cursor.callproc('update_volunteer_contact',args=(emp_id,updatevalue))
               connection.commit()
               cursor.close
               return redirect(url_for('manageusers'))

     @app.route("/schedule",methods=['GET','POST'])
     def schedule():
          if 'user' in session:
               g.user=session['user']
               if(g.user):
                    cursor = connection.cursor()
                    grade_list=['1','2','3','4','5','6','7','8','9','10','11','12']
                    adminloop=getadminDetails()
                    #shelter home select for dropdown
                    shelter_list=[]
                    cursor.callproc('get_shelterhome_details')
                    for row in cursor.fetchall():
                         shelter_list.append(row['shelter_name'])
                    volunteer_list=[]
                    cursor.callproc('get_volunteer_details')
                    for row in cursor.fetchall():
                         volunteer_list.append(row['staff_id'])
                    classes_list=[]
                    classid_list=[]
                    cursor.callproc('get_classes')
                    for row in cursor.fetchall():
                         classes_list.append(row)
                         classid_list.append(row['class_id'])

                    df_classes=pd.DataFrame(classes_list)
                    
                    
                    df_classes=df_classes.rename(columns={'class_id':'Class ID','subject':'Subject','class_schedule':'Class Schedule','grade_level':'Grade','shelter_home':'Shelter Home'})
                    
                    cursor.close
                    return render_template("schedule.html",adminloop=adminloop,classid_list=classid_list,tables=[df_classes.to_html(classes='data',header="true",index_names=False, index=False)],volunteer_list=volunteer_list,grade_list=grade_list,shelter_list=shelter_list,name=session['user'])
          else:
               return redirect(url_for('home')) 
               
     @app.route("/issues",methods=['GET','POST'])
     def issues():
          if 'user' in session:
               g.user=session['user']
               if(g.user):
                    adminloop=getadminDetails()
                    volunteer_list=[]
                    cursor=connection.cursor()
                    cursor.callproc('get_volunteer_details')
                    for row in cursor.fetchall():
                         volunteer_list.append(row['staff_id'])
                    children_list=[]
                    child_query="select * from children"
                    cursor.execute(child_query)
                    for row in cursor.fetchall():
                         children_list.append(row['student_id'])
                    reportid_list=[]
                    cursor.callproc('get_reported')
                    for row in cursor.fetchall():
                         if(row['status']=="Under investigation"):
                              reportid_list.append(row['report_id'])
                    reports_list=[]
                    cursor.callproc('get_reported')
                    for row in cursor.fetchall():
                         reports_list.append(row)
                    df_reports=pd.DataFrame(reports_list)
                    df_reports=df_reports.rename(columns={'report_id':'Report ID','report_desc':'Report Description','date_of_reporting':'Date of Reporting','status':'Status','reported_by':'Reported by'})
                    connection.commit()
                    cursor.close
                    return render_template("issues.html",adminloop=adminloop,tables=[df_reports.to_html(classes='data',header="true",index_names=False, index=False)],reportid_list=reportid_list,children_list=children_list,volunteer_list=volunteer_list,name=session['user'])
          else:
               return redirect(url_for('home')) 

     @app.route("/add_issue",methods=['GET','POST'])
     def add_issue():
          if request.method=='POST':
               issueDetails=request.form
               subject=issueDetails['subject']
               desc=issueDetails['desc']
               reportedby=issueDetails['reportedby']
               childid=issueDetails['childid']
               cursor=connection.cursor()
               cursor.callproc('report_issue',args=(desc,reportedby,childid))
               connection.commit()
               cursor.close
               return redirect(url_for('issues')) 
               
          pass

     @app.route("/add_class",methods=['GET','POST'])
     def add_class():
          if request.method=='POST':
               classDetails=request.form
               subject=classDetails['subject_name']
               classdate=classDetails['classdate']
               classtime=classDetails['classtime']
               teacherid=classDetails['teacherid']
               grade=classDetails['grade']
               shelter=classDetails['shelter']
               cursor=connection.cursor()
               cursor.callproc('add_classes',args=(subject,classdate,classtime,grade,teacherid,shelter))
               connection.commit()
               cursor.close
               return redirect(url_for('schedule')) 
               
          pass

     @app.route("/resolve_issue",methods=['GET','POST'])
     def resolve_issue():
          if request.method=='POST':
               resolveDetails=request.form
               reportid=resolveDetails['reportid']
               cursor=connection.cursor()
               cursor.callproc('update_report_status',[reportid,])
               connection.commit()
               cursor.close
               return redirect(url_for('issues')) 
               
          pass
     @app.route("/reportissue",methods=['GET','POST'])
     def reportissue():
          if 'user' in session:
               g.user=session['user']
               if(g.user):
                    return render_template("reportissue.html",name=session['user'])
          else:
               return redirect(url_for('home')) 

     @app.route("/red",methods=['GET','POST'])
     def red():
          if 'user' in session:
               g.user=session['user']
               if(g.user):
                    return render_template("user_dashy.html",name=session['user'])
          else:
               return redirect(url_for('home'))


     @app.route("/das",methods=['GET','POST'])
     def das():
          if 'user' in session:
               g.user=session['user']
               if(g.user):
                    return render_template("das.html",name=session['user'])
          else:
               return redirect(url_for('home'))


     @app.route("/blue",methods=['GET','POST'])
     def blue():
          if 'user' in session:
               g.user=session['user']
               if(g.user):
                    return render_template("admin_dashy.html",name=session['user'])
               else:
                    return render_template("mainpage.html")
          else:
               return redirect(url_for('home'))



     if __name__=="__main__":
          app.secret_key='1234'
          app.run(debug=True)
except pymysql.Error as e:
     print("Failed to connect to the database, Invalid credentials:{}".format(e))       