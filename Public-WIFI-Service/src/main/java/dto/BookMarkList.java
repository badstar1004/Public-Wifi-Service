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
public class BookMarkList {
	
	private String id;					// 북마크 아이디
	private String bookMarkGroupName;	// 북마크 그룹명
    private String X_SWIFI_MAIN_NM;		// 와이파이명
    private String idt;					// 등록일자
	
}
