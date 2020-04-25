public class RecipeController {
    @AuraEnabled 
    public static List<RecipesByCarbsWrapper> getRecipesByCarbs(String nutrient,String min, String max) {
       	Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(RecipeController.createEndpoint(nutrient, min, max));
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        HttpResponse res = http.send(request);
        //System.debug(res.getBody());
        List<RecipesByCarbsWrapper> recipes = RecipesByCarbsWrapper.parse(res.getBody());
        for(RecipesByCarbsWrapper rc : recipes) {
            System.debug(rc.calories);
        }
        return recipes;
            
	}
    public static String createEndpoint(String nutrient, String min, String max) {
        String minimum = 'min'+nutrient+'='+min;
        String maximum = '&max'+nutrient+'='+max;
        String endpoint = 'https://api.spoonacular.com/recipes/findByNutrients?' + minimum + maximum + '&number=5&apiKey=f8c481c6215045d483b55730f9ee6027';
        return endpoint;
    }
}