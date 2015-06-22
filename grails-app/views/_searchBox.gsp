<g:javascript>
  $(document).ready(function(){
    console.log("firing")
    $('.drugSearchAutoComplete').select2({
      placeholder: 'Start Typing To Search Terms',
      ajax: {
        url: "${g.createLink(controller: 'search', action: 'index')}",
        data: function (params) {
          return {
            term: params.term // search term
          };
        },
        processResults: function(data){
          console.log(data)
          return {
            results: data
          };
        }
      },
      minimumInputLength: 3
    });
    $('span.select2-selection').on('keyup', function(e){
      if(e.keyCode == 13){
        submitSearch()
      }
    });
    function submitSearch(){
      var path = $(".drugSearchAutoComplete").val().join("/").toUpperCase();
      if(path.length != 0){
        $(location).attr('href',"/" + path);
      }
      return false;
    }
  });
</g:javascript>

<select multiple name="drugSearchAutoComplete" class="drugSearchAutoComplete form-control" placeholder="Search"></select>
<span class="input-group-btn">
  <g:submitButton name="submit" class="btn btn-default" type="button" value="Search"/>
</span>
