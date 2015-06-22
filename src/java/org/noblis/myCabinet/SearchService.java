package org.noblis.myCabinet;

import java.util.List;

public interface SearchService {

    /**
     * Return a map of terms that match the search and its category
     * @param term
     * @return a map of auto complete search results
     */
    List<String> autocomplete(String term);
}
