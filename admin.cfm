<CFIF isDefined('Session.Uname') AND Session.Uname NEQ '' AND isDefined('sel_UserData.SecLevel') AND sel_UserData.SecLevel EQ 'admin'>
  	<!--- user is admin, get all users for table --->
  	<CFQUERY name="sel_AllUsers">
    	SELECT Uname, SecLevel, FirstName, LastName, eMail
    	FROM TblUsers
  	</CFQUERY>
<CFELSE>
  	<!--- not admin, redirect --->
  	<CFLOCATION url="index.cfm" addtoken="no" />
</CFIF>
<!DOCTYPE html>
<html>
	<body>
    	<CFOUTPUT>
			  <TABLE>
				  <TR>
					<TD>Username</TD>
						<TD>First Name</TD>
						<TD>Last Name</TD>
						<TD>eMail</TD>
						<TD>Sec Level</TD>
				  	</TR>
					<CFLOOP query="sel_AllUsers">
				  		<TR bgcolor="<CFIF currentrow MOD 2>LightGray<CFELSE>White</CFIF>">
							<TD>#Uname#</TD>
							<TD>#FirstName#</TD>
							<TD>#LastName#</TD>
							<TD>#eMail#</TD>
							<TD>#SecLevel#</TD>
				  		</TR>
					</CFLOOP>
      		</TABLE>
    	</CFOUTPUT>
	</body>
</html>
