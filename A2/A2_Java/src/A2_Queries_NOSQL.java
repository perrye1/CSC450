import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;

//Describes a Person object
class Person{
	
	String Full_Name;
	int Current_Annual_Salary;
	int Gross_Pay_Received;
	int Overtime_Pay;
	String Department;
	String Division;
	String Assignment_Category;
	String Position_Title;
	LocalDate Date_First_Hired;
	
	//constructor for Person
	public Person(
			String Full_Name,
			String Current_Annual_Salary,
			String Gross_Pay_Received,
			String Overtime_Pay,
			String Department,
			String Division,
			String Assignment_Category,
			String Position_Title,
			String Date_First_Hired){
		
		this.Full_Name=Full_Name;
		
		//if the respective input string is empty, set the integer member to 0
		if (!Current_Annual_Salary.equals("")){
			this.Current_Annual_Salary = Integer.parseInt(Current_Annual_Salary);
		}else {
			this.Current_Annual_Salary = 0;
		}
		
		if (!Gross_Pay_Received.equals("")){
			this.Gross_Pay_Received = Integer.parseInt(Gross_Pay_Received);
		}else {
			this.Gross_Pay_Received = 0;
		}
		
		if (!Overtime_Pay.equals("")){
			this.Overtime_Pay = Integer.parseInt(Overtime_Pay);
		}else {
			this.Overtime_Pay = 0;
		}
		
		this.Gross_Pay_Received= Integer.parseInt(Gross_Pay_Received);
		this.Overtime_Pay= Integer.parseInt(Overtime_Pay);
		this.Department=Department;
		this.Division=Division;
		this.Assignment_Category=Assignment_Category;
		this.Position_Title=Position_Title;
		this.Date_First_Hired= LocalDate.parse(Date_First_Hired);
		
	}
	
	//returns a string representation of the Person object
	public String ToString(){
		return "\""+Full_Name+"\",\""+
				Current_Annual_Salary+"\",\""+
				Gross_Pay_Received+"\",\""+
				Overtime_Pay+"\",\""+
				Department+"\",\""+
				Division+"\",\""+
				Assignment_Category+"\",\""+
				Position_Title+"\",\""+
				Date_First_Hired+"\"";
	}
	
}

public class A2_Queries_NOSQL {
	
	public static void main (String[] args) throws IOException{
		
		String inPath = "IO\\employee-sample.csv";
		BufferedReader reader = new BufferedReader(new FileReader(inPath));
		reader.readLine(); //skip the first line
		String line = ""; 
		ArrayList<Person> people = new ArrayList<Person>();

		//read in the lines, split the values, create the Person objects, and put them into the ArrayList.
		while ((line = reader.readLine()) != null) {
			String[] values = line.split("\",\""); //have to split on "," instead of just comma, since some fields contain commas in the data
			Person p =new Person(
					values[0].substring(1,values[0].length()), //since we split on ",", we have to remove the leading and trailing quotes from the whole line
					values[1],
					values[2],
					values[3],
					values[4],
					values[5],
					values[6],
					values[7],
					values[8].substring(0,values[8].length() -1 ));
			
			people.add(p);
		}
		
		reader.close();
		
		//run query 3
		System.out.println("Query 3 Results:\n");
		for(Person p : query3(people)){
			System.out.println(p.ToString());
		}
		
		//run query 4
		System.out.println("\nQuery 4 Results:\n");
		for(HashMap.Entry<String, Integer> entry : query4(people).entrySet()){
			System.out.println("\""+entry.getKey()+"\",\""+entry.getValue()+"\"");
		}
		
	}
	
	//Query 3, "List all people who work in the same department as "Adcock Sr Gerald W" - himself excluded"
	public static ArrayList<Person> query3(ArrayList<Person> people){
		String dept = "";
		ArrayList<Person> resultSet = new ArrayList<Person>();
		
		//find the department of the first person whose name matches "Adcock Sr Gerald W"
		for(Person p : people){
			if(p.Full_Name.equals("Adcock Sr Gerald W")){
				dept = p.Department;
				break;
			}
		}
		
		//find all the people whose department matches the found department from above
		for(Person p : people){
			if(p.Department.equals(dept) && !p.Full_Name.equals("Adcock Sr Gerald W")){
				resultSet.add(p);
			}
		}
		
		return resultSet;
	}
	
	//Query 4: "List all the departments and total number of employees working in that department"
	public static HashMap<String, Integer> query4(ArrayList<Person> people){
		HashMap<String, Integer> resultSet = new HashMap<String, Integer>();
		
		//use a hashMap to keep track of the number of people in each department, adding new departments when encountered
		for(Person p: people){
			if(resultSet.containsKey(p.Department)){
				resultSet.put(p.Department, resultSet.get(p.Department) + 1);
			}else{
				resultSet.put(p.Department, 1);
			}
		}
		
		return resultSet;
	}
}