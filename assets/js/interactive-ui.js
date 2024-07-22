document.addEventListener('DOMContentLoaded', function() {
    let currentPage = 1;
    const itemsPerPage = 3;
  
    function displayEvents(page) {
      const startIndex = (page - 1) * itemsPerPage;
      const endIndex = page * itemsPerPage;
      const eventsContainer = document.getElementById('eventsContainer');
      eventsContainer.innerHTML = '';
  
      eventsData.slice(startIndex, endIndex).forEach((event, index, array) => {
        const li = document.createElement('li');
        li.classList.add('my-2');
        li.innerHTML = `
          <form action="" method="post">
            <input type="checkbox" name="checkbox-${startIndex + index}" id="">
            <label class="" for="checkbox-${startIndex + index}">${event.title}</label>
            <p class="my-0">${event.description}</p>
            ${index < array.length - 1 ? '<div class="border-bottom border-1 w-100"></div>' : ''}
          </form>
        `;
        eventsContainer.appendChild(li);
      });
    }
  
    document.getElementById('prevPage').addEventListener('click', function(e) {
      e.preventDefault();
      if (currentPage > 1) {
        currentPage--;
        displayEvents(currentPage);
      }
    });
  
    document.getElementById('nextPage').addEventListener('click', function(e) {
      e.preventDefault();
      if (currentPage * itemsPerPage < eventsData.length) {
        currentPage++;
        displayEvents(currentPage);
      }
    });
  
    // Initial display
    displayEvents(currentPage);
  });
  
  
    // Show or hide the button based on scroll position
    window.onscroll = function() {
        if (document.body.scrollTop > 100 || document.documentElement.scrollTop > 100) {
            document.getElementById('backToTop').style.display = 'block';
        } else {
            document.getElementById('backToTop').style.display = 'none';
        }
    };

    // Scroll to top when the button is clicked
    document.getElementById('backToTop').onclick = function() {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    };  



    document.getElementById('photoInput').addEventListener('change', function(event) {
      const file = event.target.files[0];
      const reader = new FileReader();
      reader.onload = function(e) {
          document.getElementById('profileImage').src = e.target.result;
      };
      reader.readAsDataURL(file);
  });
  
  document.getElementById('profileForm').addEventListener('submit', function(event) {
      event.preventDefault();
      // Add your form submission logic here
      alert('Form submitted!');
  });
  
  // document.getElementById('profile-form').addEventListener('submit', function(event) {
  //     event.preventDefault();
  //     alert('Profile updated successfully!');
  //     // Add your form submission code here
  // });