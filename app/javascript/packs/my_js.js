//console.log('Hello from My JS')

window.addEventListener("DOMContentLoaded", () => {
    const owned_tab = document.querySelector("#owned-tab");
    const owned_tab_content = document.querySelector('#owned');
    const wishlist_tab = document.querySelector("#wishlist-tab");
    const wishlist_tab_content = document.querySelector('#wishlist');

    owned_tab.addEventListener('click', ()=> {
        //Being showed
        owned_tab_content.classList.toggle('active');
        owned_tab_content.classList.toggle('show');
        //Hide
        wishlist_tab_content.classList.toggle('active');
        wishlist_tab_content.classList.toggle('show');
    })

    wishlist_tab.addEventListener('click', ()=> {
        //Being showed
        wishlist_tab_content.classList.toggle('active');
        wishlist_tab_content.classList.toggle('show');
        //Hide
        owned_tab_content.classList.toggle('active');
        owned_tab_content.classList.toggle('show');
    })
});