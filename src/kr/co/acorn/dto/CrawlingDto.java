package kr.co.acorn.dto;

public class CrawlingDto {
	private String date;
	private String open;
	private String high;
	private String low;
	private String close;
	private String volume;
	private String marketcap;
	
	
	
	public CrawlingDto() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CrawlingDto(String date, String open, String high, String low, String close, String volume,
			String marketcap) {
		super();
		this.date = date;
		this.open = open;
		this.high = high;
		this.low = low;
		this.close = close;
		this.volume = volume;
		this.marketcap = marketcap;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getOpen() {
		return open;
	}

	public void setOpen(String open) {
		this.open = open;
	}

	public String getHigh() {
		return high;
	}

	public void setHigh(String high) {
		this.high = high;
	}

	public String getLow() {
		return low;
	}

	public void setLow(String low) {
		this.low = low;
	}

	public String getClose() {
		return close;
	}

	public void setClose(String close) {
		this.close = close;
	}

	public String getVolume() {
		return volume;
	}

	public void setVolume(String volume) {
		this.volume = volume;
	}

	public String getMarketcap() {
		return marketcap;
	}

	public void setMarketcap(String marketcap) {
		this.marketcap = marketcap;
	}
}
