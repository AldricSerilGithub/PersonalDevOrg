function confirmCancel() {
   var isCancel = confirm("Are you sure you want to logout?");
   if (isCancel) return true;

   return false;
}