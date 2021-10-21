
    const owned_tab = document.querySelector("#owned-tab");
    const owned_tab_content = document.querySelector('#owned');
    const wishlist_tab = document.querySelector("#wishlist-tab");
    const wishlist_tab_content = document.querySelector('#wishlist');

    owned_tab.addEventListener('click', ()=> {
        
        if(!owned_tab_content.classList.contains('active') && !owned_tab_content.classList.contains('show'))
        {
            owned_tab_content.classList.add('active');
            owned_tab_content.classList.add('show');
            owned_tab.ariaSelected = true;
        }
        //Hide
        wishlist_tab_content.classList.remove('active');
        wishlist_tab_content.classList.remove('show');
        wishlist_tab.ariaSelected = false;

        console.log('owned button clicked');
    })

    wishlist_tab.addEventListener('click', ()=> {
        //Being showed
        if(!wishlist_tab_content.classList.contains('active') && !wishlist_tab_content.classList.contains('show'))
        {
            wishlist_tab_content.classList.add('active');
            wishlist_tab_content.classList.add('show');
            wishlist_tab.ariaSelected = true;
        }

        owned_tab_content.classList.remove('active');
        owned_tab_content.classList.remove('show');
        owned_tab.ariaSelected = false;

        console.log('wishlist button clicked');
    })
