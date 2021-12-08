<CFIF isDefined('FORM.cmd') AND FORM.cmd EQ 'login'>
  <!--- do nothing, continue loading page --->
<CFELSEIF isDefined('FORM.cmd') AND FORM.cmd EQ 'SaveLogin'>
  <CFQUERY name="Authenticate">
    SELECT
      PwordHash,
      PwordSalt
    FROM
      Users
    WHERE
      Username = '<CFOUTPUT>#FORM.Uname#</CFOUTPUT>'
  </CFQUERY>

  <CFIF !Authenticate.recordCount>
    <!--- The user is not in the database.  Redirect them to the login page --->
    <CFLOCATION url="index.cfm" addtoken="no"/>
  </CFIF>

  <CFIF Authenticate.PwordHash EQ hash(FORM.Pword & Authenticate.PwordSalt, "SHA-512")>
    <!--- User is authenticated. Run whatever code is needed to establish a user session. --->
  <CFELSE>
    <!--- User is not authenticated. Redirect them to the login page --->
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
