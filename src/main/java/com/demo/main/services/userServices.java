package com.demo.main.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.demo.main.model.user;
import com.demo.main.repository.userRepository;

@Service
public class userServices {
	@Autowired
	private userRepository userRepository;

	public user createUser(user user) {
		return userRepository.save(user);
	}
	public user createAdmin(user admin) {
	    admin.setRole("ADMIN");
	    return userRepository.save(admin);
	}

	
	public user verifyUser(user user) {
		return userRepository.findByNameAndPassword(user.getName(),user.getPassword());
	}
	
	public Optional<user> findById(int id) {
		return userRepository.findById(id);
	}
	
	public List<user> findAll(){
		return userRepository.findAll();
	}
	
	public void deleteById(int id) {
        userRepository.deleteById(id);
    }
}
