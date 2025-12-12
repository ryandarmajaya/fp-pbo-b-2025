<%
class Config{
	public static String getDatabaseName(){
		return "q2_webpro_2025";
	}
	
	public static String getDatabaseHost(){
		return "localhost:3306";
	}
	
	// Change with your MySQL username
	public static String getDatabaseUser(){
		return "root";
	}
	
	// Change with your MySQL password
	public static String getDatabasePass(){
		return "";
	}
	
	// for windows
	public static String getTempDir(){
		return "c:\\temp\\q2_webpro_2025";
	}

	// for linux
	// public static String getTempDir(){
	//	return "/tmp/q2_webpro_2025";
	// } -->
}
%>