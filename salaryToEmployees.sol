//SPDX-License-Identifier:MIT
pragma solidity ^0.8.7;

// distributing funds from company to employees within time

//first getting the info of employees

struct EmployeeDetails{
    string name;
    uint id;
    uint salary;
    bool check;
}

contract PayDay{
    mapping(address => EmployeeDetails) employees;
    address payable owner;
     // modifier
     modifier onlyOwner{
         require(msg.sender==owner);
         _;
     }

     constructor(){
         owner=payable(msg.sender);
     }
    //owner is going to add the employees
    function details(string memory _name,uint code,uint _salary,address payable a)external onlyOwner{
        employees[a].name=_name;
        employees[a].id=code;
        employees[a].salary=_salary;
        employees[a].check = true;
    }

    //returning the details
    function returnDetails()external view onlyOwner returns(string memory,uint ){
        return(employees[msg.sender].name,employees[msg.sender].id);
    }

    // owner can modifiy the details of employees
    function update(address payable b)external onlyOwner{
        employees[b].check=false;
    }
    

    //company or organization pay to contract
    function payToContract()external payable onlyOwner{}
    
    //checking the contract balance
    function contractBalance()external view returns(uint){
        return address(this).balance;
    }

    //employees can claim their salary 
    function claimSalary()external view {
        require(!(employees[msg.sender].check),"not an employee");

    }

     
}