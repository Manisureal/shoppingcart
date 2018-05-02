function toggle_visibility(id) {
  var e = document.getElementById(id);
  if(e.style.display == 'inline-table')
    e.style.display = 'none';
  else
    e.style.display = 'inline-table';
}
