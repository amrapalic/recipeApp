public class PrintDuplicates {
    public static void printFunction() {
        Map<Integer,String> sampleMap = new Map<Integer,String>{1 => 'John', 2 => 'Mike', 3 => 'Eddy', 4 => 'John', 5 => 'Eddy'};
        List<String> names = new List<String>();
        for(String name : sampleMap.values()) {
            if(names.contains(name)) { system.debug(name); }
            else { names.add(name); }
        } 
    }
}