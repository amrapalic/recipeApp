public class RecipesByCarbsWrapper {

	@AuraEnabled public Integer calories;
	@AuraEnabled public String carbs;
	@AuraEnabled public String fat;
	@AuraEnabled public Integer id;
	@AuraEnabled public String image;
	@AuraEnabled public String imageType;
	@AuraEnabled public String protein;
	@AuraEnabled public String title;

	
	public static List<RecipesByCarbsWrapper> parse(String json) {
		return (List<RecipesByCarbsWrapper>) System.JSON.deserialize(json, List<RecipesByCarbsWrapper>.class);
	}
}