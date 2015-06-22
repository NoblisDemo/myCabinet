<g:javascript>
  $(document).ready(function(){
    $('.drugSearchAutoComplete').select2({
      placeholder: 'Start Typing To Search Terms',
      ajax: {
        url: "${g.createLink(controller: 'search', action: 'index')}",
        data: function (params) {
          return {
            term: params.term // search term
          };
        },
        processResults: function(data){ //form results from call into json
          //ex return: [{'text':'Drugs', 'children':[{'text':'Oxycodine', 'id':'Oxycodine'}]}]
          var resultsMap = {}
          //Creating children maps
          $.each(data, function(index, value){
            if(value.category in resultsMap){
                resultsMap[value.category].push({'text':value.label, 'id':value.label})
            }
            else {
                resultsMap[value.category] = [{'text':value.label, 'id':value.label}]
            }
          });

          //Creating categories
          var resultsArr = []
          $.each(resultsMap, function(key, value){
            resultsArr.push({'text': key, 'children':value})
          });

          return {
            results: resultsArr
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
