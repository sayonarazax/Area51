package com.example.controller;

import com.example.domain.Message;
import com.example.domain.User;
import com.example.repo.MessageRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.time.Instant;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Map;
import java.util.UUID;

@Controller
public class MainController {
    @Autowired
    private MessageRepo messageRepo;

    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping("/")
    public String greeting(Model model) {
        model.addAttribute("navbarHome", true);
        return "home";
    }

    @GetMapping("/main")
    public String mainPage(@RequestParam(required = false, defaultValue = "")String filter, String name, Model model) {
        Iterable<Message> messages = messageRepo.findAll();

        if (filter != null && !filter.isEmpty()) {
            messages = messageRepo.findByTag(filter);
        } else {
            messages = messageRepo.findAll();
        }

        model.addAttribute("navbarMsg", true);
        model.addAttribute("messages", messages);
        model.addAttribute("filter", filter);
        return "mainPage";
    }

    @PostMapping("/main")
    public String add(@AuthenticationPrincipal @SessionAttribute("user") User author,
                      @Valid Message message,
                      BindingResult bindingResult,
                      Model model,
                      @RequestParam("file") MultipartFile file

    ) throws IOException {
        message.setAuthor(author);
        if(!StringUtils.isEmpty(author.getTimezone())) {
            ZoneId zoneId = ZoneId.of(author.getTimezone());
            Instant msgTime = Instant.now();;
            ZonedDateTime zonedDate = ZonedDateTime.ofInstant(msgTime, zoneId);
            DateTimeFormatter formatter2 = DateTimeFormatter.ofPattern("MM.dd - HH:mm z");
            message.setDatemsg(zonedDate.format(formatter2));
        }
        if (bindingResult.hasErrors()) {
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errorsMap);
            model.addAttribute(message);
        } else  {
            if (file != null && !file.getOriginalFilename().isEmpty()) {
                File uploadDir = new File(uploadPath);
                if(!uploadDir.exists()) {
                    uploadDir.mkdir();
                }

                String uuidFile = UUID.randomUUID().toString();
                String resultFilename = uuidFile + "." + file.getOriginalFilename();

                file.transferTo(new File(uploadPath + "/" + resultFilename));

                message.setFilename(resultFilename);
            }

            model.addAttribute("navbarMsg", true);
            model.addAttribute("message", null);
            messageRepo.save(message);
        }

        Iterable<Message> messages = messageRepo.findAll();
        model.addAttribute("messages", messages);

        return "mainPage";
    }


}