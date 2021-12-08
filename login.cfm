<CFIF isDefined('FORM.cmd') AND FORM.cmd EQ 'login'>
  <!--- do nothing, continue loading page --->
<CFELSEIF isDefined('FORM.cmd') AND FORM.cmd EQ 'SaveLogin'>
  <CFQUERY name="Authenticate">
    SELECT PwordHash, PwordSalt
    FROM Users
    WHERE Username = '<CFOUTPUT>#FORM.Uname#</CFOUTPUT>'
  </CFQUERY>

  <CFIF !Authenticate.recordCount>
    <!--- The user is not in the database.  Redirect them to the login page --->
    <CFLOCATION url="index.cfm" addtoken="no"/>
  </CFIF>

  <CFIF Authenticate.PwordHash EQ hash(FORM.Pword & Authenticate.PwordSalt, "SHA-512")>
    <!--- User is authenticated --->
	<CFQUERY name="sel_UserData">
		SELECT Uname, SecLevel
		FROM Users
		WHERE Username = '<CFOUTPUT>#FORM.Uname#</CFOUTPUT>'
	</CFQUERY>
	<CFLOCK timeout=20 scope="Session" type="Exclusive">
		<CFSET Session.Uname = sel_UserData.Uname>
		<CFSET Session.SecLevel = sel_UserData.SecLevel>
	</CFLOCK>
	<!--- send to profile page --->
	<CFLOCATION url="profile.cfm" addToken="no" />
  <CFELSE>
    <!--- User is not authenticated. Redirect them to the login page --->
    <CFLOCATION url="index.cfm" addtoken="no"/>
  </CFIF>
<CFELSE>
  <!--- redirect --->
  <CFLOCATION url="index.cfm" addtoken="no"/>
</CFIF>
<!DOCTYPE html>
<html>
	<body>
    <FORM action="login.cfm" addtoken="no">
      Username: <INPUT type="text" name="Uname" id="Uname"/><BR/>
      Password: <INPUT type="password" name="Pword" id="Pword"/><BR/>
      <INPUT type="hidden" name="cmd" id="cmd" value="SaveLogin"/>
      <INPUT type="submit" name="submit" id="submit" value="LOGIN"/>
    </FORM>
	</body>
</html>
