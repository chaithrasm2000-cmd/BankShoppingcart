package com.demo.main.repository;


import org.springframework.data.jpa.repository.JpaRepository;
import com.demo.main.model.user;

public interface userRepository extends JpaRepository<user, Integer>{
	user findByNameAndPassword(String name,String password);
}
