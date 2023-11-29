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
public class BookMarkGroup {
	
	private int id;					// 아이디
	private String bookMarkName;	// X 좌표
    private String seq;				// Y 좌표
    private String idt;				// 등록일자
    private String udt;				// 수정일자
	
}
