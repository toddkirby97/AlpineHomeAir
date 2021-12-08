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
<CFIF isDefined('sel_UserData.SecLevel') AND sel_UserData.SecLevel EQ 'admin'>
  	<!--- user is admin, get all users for table --->
  	<CFQUERY name="sel_AllUsers">
    	SELECT Uname, SecLevel, FirstName, LastName, eMail
    	FROM TblUsers
  	</CFQUERY>
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
			  	<TABLE>
				  	<TR>
						<TD>Username</TD>
						<TD>First Name</TD>
						<TD>Last Name</TD>
						<TD>eMail</TD>
						<TD>Sec Level</TD>
				  	</TR>
					<CFLOOP query="sel_AllUsers">
				  		<TR>
							<TD>#Uname#</TD>
							<TD>#FirstName#</TD>
							<TD>#LastName#</TD>
							<TD>#eMail#</TD>
							<TD>#SecLevel#</TD>
				  		</TR>
					</CFLOOP>
      			</TABLE>
    		</CFIF>
    	</CFOUTPUT>
	</body>
</html>
