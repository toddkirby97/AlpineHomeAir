<CFIF isDefined('Session.Uname') AND Session.Uname NEQ ''>
  	<!--- user signed in, get their data --->
  	<CFQUERY name="sel_UserData">
    	SELECT Uname, SecLevel, FirstName, LastName, eMail
    	FROM TblUsers
    	WHERE Uname = '<CFOUTPUT>#Session.Uname#</CFOUTPUT>'
  	</CFQUERY>
<CFELSE>
  	<!--- nobody signed in, redirect --->
  	<CFLOCATION url="index.cfm" addtoken="no" />
</CFIF>
<!DOCTYPE html>
<html>
	<body>
    	<CFOUTPUT>
    		Username: #sel_UserData.Uname#<BR/>
    		First Name: #sel_UserData.FirstName#<BR/>
    		Last Name: #sel_UserData.LastName#<BR/>
    		eMail: #sel_UserData.eMail#<BR/>
    		<CFIF sel_UserData.SecLevel EQ 'admin'>
				<FORM action="admin.cfm" method="post">
					<INPUT type="submit" name="submit" value="ADMIN PAGE"/>
				</FORM>
    		</CFIF>
    	</CFOUTPUT>
	</body>
</html>
