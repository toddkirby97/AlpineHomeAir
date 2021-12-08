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
    <CFSET Session.user = FORM.Uname>
    <CFSET Session.SecLevel = 'basic'>
  </CFLOCK>
<!--- if cmd is submitted and cmd is signup --->
<CFELSEIF isDefined("FORM.cmd") AND FORM.cmd EQ "signup">

<!--- otherwise, redirect back to index --->
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
