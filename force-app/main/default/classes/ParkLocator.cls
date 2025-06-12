public class ParkLocator {
    public static List<String> country(String countryName) {
        ParkService.ParksImplPort stub = new ParkService.ParksImplPort();
        List<String> parkNames = new List<String>();

        String[] response = stub.byCountry(countryName);
        if (response != null) {
            parkNames.addAll(response);
        }

        return parkNames;
    }
}