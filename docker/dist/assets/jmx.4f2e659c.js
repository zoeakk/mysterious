import{s as e}from"./request.207160df.js";const r=t=>e({url:"/jmx/list",method:"get",params:t}),o=t=>e({url:"/jmx/delete/"+t,method:"get"}),d=(t,n)=>e({url:"/jmx/upload/"+t,method:"post",headers:{"Content-Type":"multipart/form-data"},data:n}),m=t=>e({url:"/jmx/download/"+t,method:"get"}),s=t=>e({url:"/jmx/addOnline",method:"post",data:t}),l=(t,n)=>e({url:"/jmx/updateOnline/"+t,method:"post",data:n}),u=t=>e({url:"/jmx/getOnline/"+t,method:"get"});export{m as a,s as b,l as c,o as d,r as e,u as g,d as u};
