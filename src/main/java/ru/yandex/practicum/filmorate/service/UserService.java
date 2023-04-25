package ru.yandex.practicum.filmorate.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import ru.yandex.practicum.filmorate.exception.NotFoundException;
import ru.yandex.practicum.filmorate.exception.ValidationException;
import ru.yandex.practicum.filmorate.model.User;
import ru.yandex.practicum.filmorate.storage.UserStorage;

import java.util.List;


@Service
@RequiredArgsConstructor
public class UserService {
    private final UserStorage userStorage;

    public List<User> getAllUsers() {
        return userStorage.getAllUsers();
    }

    public User getUserById(Integer id) {
        User user = userStorage.getUserById(id);
        if (user == null) {
            throw new NotFoundException("Пользователь не найден");
        }
        return user;
    }

    public User putUser(User user) {
        if (userStorage.getAllUsers().contains(user)) {
            throw new ValidationException("Пользователь уже присутствует в базе данных");
        }
        if (user.getName() == null || user.getName().isEmpty()) {
            user.setName(user.getLogin());
        }
        return userStorage.putUser(user);
    }

    public User updateUser(User user) {
        if (user.getId() == null || !userStorage.getAllUsers().contains(user)) {
            throw new NotFoundException("Пользователь не найден");
        }
        if (user.getName() == null || user.getName().isEmpty()) {
            user.setName(user.getLogin());
        }
        return userStorage.updateUser(user);
    }

    private User checkAndReturnUser(Integer userId) {
        User user = userStorage.getUserById(userId);
        if (userId == null || user == null) {
            throw new NotFoundException("Пользователь не найден");
        }
        return user;
    }
}