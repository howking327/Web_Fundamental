package kr.co.acorn.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kr.co.acorn.dto.MemberDto;
import kr.co.acorn.utill.ConnLocator;

public class MemberDao {
	private static MemberDao single;

	private MemberDao() {
	}

	public static MemberDao getInstance() {
		if (single == null) {
			single = new MemberDao();
		}
		return single;
	}
	
	public boolean isEmail(String email) {
		boolean isSuccess = false;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT m_email ");
			sql.append("FROM member ");
			sql.append("WHERE m_email = ? ");
			pstmt = con.prepareStatement(sql.toString());
			
			int index = 0;
			pstmt.setString(++index, email);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				index=0;
				isSuccess = true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(con!=null) con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return isSuccess;
	}
	
	public boolean isCorrect(String email, String password) {
		boolean isSuccess = false;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT COUNT(m_email) ");
			sql.append("FROM member ");
			sql.append("WHERE m_email = ? AND m_pwd = PASSWORD(?) ");
			pstmt = con.prepareStatement(sql.toString());
			
			int index = 0;
			pstmt.setString(++index, email);
			pstmt.setString(++index, password);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				index=0;
				int count = rs.getInt(++index);
				if(count!=0) {
					isSuccess = true;
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(con!=null) con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return isSuccess;
	}
	
	public MemberDto getMember(MemberDto dto) {
		MemberDto memberDto = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT m_email, m_name, m_phone, date_format(m_regdate,'%Y/%m/%d') ");
			sql.append("FROM member ");
			sql.append("WHERE m_email = ? AND m_pwd = PASSWORD(?) ");
			pstmt = con.prepareStatement(sql.toString());
			
			int index = 0;
			pstmt.setString(++index, dto.getEmail());
			pstmt.setString(++index, dto.getPassword());
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				index=0;
				String email = rs.getString(++index);
				String name = rs.getString(++index);
				String phone = rs.getString(++index);
				String regdate = rs.getString(++index);
				memberDto = new MemberDto(email,name,null,phone,regdate);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(con!=null) con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return memberDto;
	}
	
	
	public int getTotalRows() {
		int count = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT COUNT(m_name) ");
			sql.append("FROM member ");
			pstmt = con.prepareStatement(sql.toString());
			
			int index = 0;
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				index=0;
				count = rs.getInt(++index);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(con!=null) con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return count;
	}
	
	public ArrayList<MemberDto> select(int start, int len) {
		ArrayList<MemberDto> list = new ArrayList<MemberDto>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT m_email, m_name, m_regdate ");
			sql.append("FROM member ");
			sql.append("ORDER BY m_regdate DESC ");
			sql.append("LIMIT ?, ? ");
			pstmt = con.prepareStatement(sql.toString());
			
			int index = 0;
			pstmt.setInt(++index, start);
			pstmt.setInt(++index, len);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				index=0;
				String email = rs.getString(++index);
				String name = rs.getString(++index);
				String regdate = rs.getString(++index);
				
				list.add(new MemberDto(email,name,null,null,regdate));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(con!=null) con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return list;
	}
	
	public MemberDto select(String email) {
		MemberDto dto = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT m_email, m_name, m_pwd, m_phone, m_regdate ");
			sql.append("FROM member ");
			sql.append("WHERE m_email = ? ");
			pstmt = con.prepareStatement(sql.toString());
			
			int index = 0;
			pstmt.setString(++index, email);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				index=0;
				email = rs.getString(++index);
				String name = rs.getString(++index);
				String password = rs.getString(++index);
				String phone = rs.getString(++index);
				String regdate = rs.getString(++index);
				dto = new MemberDto(email,name,password,phone,regdate);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(con!=null) con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return dto;
	}
	
	public boolean update(MemberDto dto) {
		boolean isSuccess = false;
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("UPDATE member ");
			sql.append("SET  m_name=?, m_pwd=PASSWORD(?), m_phone=? ");
			sql.append("WHERE m_email=? ");
			
			pstmt = con.prepareStatement(sql.toString());
			int index = 0;
			
			pstmt.setString(++index, dto.getName());
			pstmt.setString(++index, dto.getPassword());
			pstmt.setString(++index, dto.getPhone());
			pstmt.setString(++index, dto.getEmail());
			pstmt.executeUpdate();
			
			isSuccess = true;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if(pstmt!=null) pstmt.close();
				if(con!=null) con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return isSuccess;
	}
}
