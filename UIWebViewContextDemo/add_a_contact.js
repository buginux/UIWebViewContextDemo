var contactForm = document.forms[0];
var addContact = function() {
    var name = contactForm.name.value;
    var phone = contactForm.phone.value;
    var address = contactForm.address.value;
    var contact = XGContact.contactWithNamePhoneAddress(name, phone, address);
    myStore.addContact(contact);
};
contactForm.addEventListener('submit', addContact);
