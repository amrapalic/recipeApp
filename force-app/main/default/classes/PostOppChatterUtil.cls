public class PostOppChatterUtil {
    public static void postToChatter(List<Opportunity> oppList) {
        List<FeedItem> posts = new List<FeedItem>();
        for(Opportunity opp : oppList) {
            if(opp.Amount > 100000) {
                FeedItem post = new FeedItem();
            	post.ParentId = opp.Opportunity_Approver__c;
            	post.Body = 'Awesome Opporunity Approved by @'+opp.Opportunity_Approver__r.Name;
                posts.add(post);
            }
          insert posts;  
        }
    }
}