public class StringListTest {
    public static List<String> generateStringList(Integer count){
        List<String> res=new List<String>();
        for (Integer num=0;num<count;num++){
            res.add('Test '+num);
        }
        return res;
    }
}