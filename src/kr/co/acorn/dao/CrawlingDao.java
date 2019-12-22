package kr.co.acorn.dao;

import java.io.IOException;
import java.util.ArrayList;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import kr.co.acorn.dto.CrawlingDto;

public class CrawlingDao {
	private static CrawlingDao single;

	private CrawlingDao() {
	}

	public static CrawlingDao getInstance() {
		if (single == null) {
			single = new CrawlingDao();
		}
		return single;
	}

	public ArrayList<CrawlingDto> crawl(int startdate, int enddate){
		   ArrayList<CrawlingDto> list = new ArrayList<CrawlingDto>();
		  
		   String url = "https://coinmarketcap.com/currencies/bitcoin/historical-data/?start="+startdate+"&end="+enddate;
		   Document doc = null;
	
	try {
		doc = Jsoup.connect(url).get();
	} catch (IOException e1) {
		// TODO Auto-generated catch block
		e1.printStackTrace();
	}
	Elements elements = doc.select(".cmc-table__table-wrapper-outer table tbody tr");
	
	
		for (int i = 0; i < elements.size(); i++) {
			Element trElement = elements.get(i);
			String date = trElement.child(0).text();
			String open = trElement.child(1).text();
			String high = trElement.child(2).text();
			String low = trElement.child(3).text();
			String close = trElement.child(4).text();
			String volume = trElement.child(5).text();
			String cap = trElement.child(6).text();
			
			list.add(new CrawlingDto(date,open,high,low,close,volume,cap));
			
		}
		return list;
}
	
}
