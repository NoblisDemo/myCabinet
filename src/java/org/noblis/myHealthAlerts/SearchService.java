package org.noblis.myHealthAlerts;

import java.util.List;
import java.util.Map;

public interface SearchService {

    /**
     * Return a map of terms that match the search and its category
     * @param term
     * @return a map of auto complete search results
     */
    List<Map> autocomplete(String term);

    List<Map> countReactionsByDrug(String term);

    List<Map> countReactionsByDrugOverTime(String term);
}
