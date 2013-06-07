function sayHello() {
    if (document.getElementById('foo').innerHTML == 'Hi there'){
        document.getElementById('foo').innerHTML = 'Click me!';
        
    }else{
        document.getElementById('foo').innerHTML = 'Hi there'; 
    }
}
 