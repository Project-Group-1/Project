package com.dolbommon.dbmon.Teacher;

import java.util.HashSet;

public interface TeacherDaoImp {
	
	public TeacherVO selectTeacher(String userid);
	public MemberVO selectTMember(String userid);
	public int updateIntro(TeacherVO vo);
	public int updateType(TeacherVO vo);
	public int updateWage(TeacherVO vo);
	public int updatePic(TeacherVO vo);
	public int updateAge(TeacherVO vo);
	public int updateActivity(TeacherVO vo);
	public int updateCCTV(TeacherVO vo);
	public HashSet<ExperienceVO> selectExp(String userid);
	public int hitCount(TeacherVO vo);
	public int findIdT(ExperienceVO vo);
	public int updateExp(ExperienceVO evo);
	public int insertExp(ExperienceVO evo);
	public int deleteExp(ExperienceVO evo);
	public int selectLastEdit(String userid);
	//선생 지도 받기
	public MemberVO selectTMap(String userid);
	public int updateTMap(MemberVO mvo);
	public int updateArea(TeacherVO vo);
	
}

