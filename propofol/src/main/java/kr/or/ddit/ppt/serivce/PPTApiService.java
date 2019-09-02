package kr.or.ddit.ppt.serivce;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.UUID;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.io.IOUtils;
import org.apache.poi.xslf.usermodel.XMLSlideShow;
import org.apache.poi.xslf.usermodel.XSLFPictureData;
import org.apache.poi.xslf.usermodel.XSLFPictureShape;
import org.apache.poi.xslf.usermodel.XSLFSlide;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

@Service
public class PPTApiService {

   public void createPPT(String fileName) throws IOException {
      //프리젠테이션 만들기 시작
      XMLSlideShow ppt = new XMLSlideShow();
      
      //슬라이드 만듬 
      XSLFSlide slide = ppt.createSlide();
      
      //reading an image
      File image = new File("d://ppt//"+fileName+".jpeg");
      
      //converting it into a byte array
      byte[] picture = IOUtils.toByteArray(new FileInputStream(image));
      
      //adding the image to the presentation
      int idx = ppt.addPicture(picture, XSLFPictureData.PICTURE_TYPE_PNG);
      
      //creating a slide with given picture on it
      XSLFPictureShape pic = slide.createPicture(idx);
      
      //creating a file object 
      File file = new File("d://ppt//example1.pptx");
      FileOutputStream out = new FileOutputStream(file);
      
      //saving the changes to a file
      ppt.write(out);
      System.out.println("image added successfully");
      out.close();	
   }
   
   public ModelAndView createImage(String pptData) throws Exception {
	   FileOutputStream stream = null;
       ModelAndView mav = new ModelAndView();
       mav.setViewName("jsonView");        
       try{
           System.out.println("binary file   "  + pptData);
           if(pptData == null || pptData=="") {
               throw new Exception();    
           }
           
           pptData = pptData.replaceAll("data:image/jpeg;base64,", "");
           byte[] file = Base64.decodeBase64(pptData);
           System.out.println("file  :::::::: " + file + " || " + file.length);
           String fileName=  UUID.randomUUID().toString();
           
           stream = new FileOutputStream("d:\\ppt\\"+fileName+".jpeg");
           stream.write(file);
           stream.close();
           System.out.println("파일 작성 완료");
           mav.addObject("msg","ok");
           
           createPPT(fileName);
       }catch(Exception e){
           System.out.println("파일이 정상적으로 넘어오지 않았습니다");
           mav.addObject("msg","no");
           return mav;
       }finally{
           stream.close();
       }
       return mav;
   }
} 