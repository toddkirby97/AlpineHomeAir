<!--- if cmd is submitted and cmd is SaveSignup --->
<CFIF isDefined("FORM.cmd") AND FORM.cmd EQ "SaveSignup">
 <!--- set the salt variable --->
 <CFSET passwordSalt = hash(generateSecretKey("AES"),"SHA-512")>
 <!--- insert the user data into the table --->
 <CFQUERY name="ins_NewUser">
    INSERT INTO TblUsers (Uname, PwordHash, PwordSalt, SecLevel, FirstName, LastName, eMail)
    VALUES (
     '#FORM.Uname#',
     '<CFQUERYPARAM cfsqltype="char" value="#hash(FORM.Pword & passwordSalt,'SHA-512')#">',
     '<CFQUERYPARAM cfsqltype="char" value="#passwordSalt#">',
     'basic',
     '#FORM.FirstName#',
     '#FORM.LastName#',
     '#FORM.eMail#'     
    )
  </CFQUERY>
  <!--- start session --->
  <CFLOCK timeout=20 scope="Session" type="Exclusive">
    <CFSET Session.Uname = FORM.Uname>
    <CFSET Session.SecLevel = 'basic'>
  </CFLOCK>
  <!--- send to profile page --->
  <CFLOCATION url="profile.cfm" addToken="no" />
<CFELSEIF isDefined("FORM.cmd") AND FORM.cmd EQ "signup">
   <!--- if cmd is submitted and cmd is signup, do nothing, continue loading page --->
<CFELSE>
  <!--- otherwise, redirect back to index --->
  <CFLOCATION url="index.cfm" addToken="no" />
</CFIF>
<!DOCTYPE html>
<html>
  <body>
      <!--- Enter user data --->
      <FORM action="signup.cfm" method="post">
        User Name:<INPUT type="text" name="Uname" id="Uname"/><BR/>
        First Name:<INPUT type="text" name="Uname" id="Uname"/><BR/>
        Last Name:<INPUT type="text" name="Uname" id="Uname"/><BR/>
        eMail:<INPUT type="text" name="Uname" id="Uname"/><BR/>
        Password: <INPUT type="password" name="Pword" id="Pword"/><BR/>
        <INPUT type="hidden" name="cmd" id="cmd" value="SaveSignup"/>
        <INPUT type="submit" name="submit" id="submit" value="SAVE"/>
      </FORM>
   </body>
</html>
