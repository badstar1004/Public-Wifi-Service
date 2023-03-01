package dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
public class WifiLocationHistory {
	
	private int id;			// 아이디
	private String LNT;		// X 좌표
    private String LAT;		// Y 좌표
    private String IDT;		// 조회일자
	
}
