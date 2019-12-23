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
	
	public int getTotalRows() {
		int count = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT COUNT(ename) ");
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
				
				list.add(new MemberDto());
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
}
