<CFIF isDefined("FORM.cmd") AND FORM.cmd EQ "SaveSignup">


<CFELSEIF isDefined("FORM.cmd") AND FORM.cmd EQ "signup">

<CFELSE>
  <CFLOCATION url="index.cfm" addToken="no" />
</CFIF>
<!DOCTYPE html>
<html>
  <body>
    <CFIF isDefined("FORM.cmd") AND FORM.cmd EQ "signup">
      <!--- Enter user data --->
      <FORM action="signup.cfm" method="post">
        User Name:<INPUT type="text" name="Uname" id="Uname"/><BR/>
        First Name:<INPUT type="text" name="Uname" id="Uname"/><BR/>
        Last Name:<INPUT type="text" name="Uname" id="Uname"/><BR/>
        eMail:<INPUT type="text" name="Uname" id="Uname"/><BR/>
        Password: <INPUT type="password" name="Pword" id="Pword"/>
        <INPUT type="hidden" name="cmd" id="cmd" value="SaveSignup"/>
      </FORM>
    <CFELSEIF isDefined("FORM.cmd") AND FORM.cmd EQ "SaveSignup">
    
    </CFIF>
  </body>
</html>
