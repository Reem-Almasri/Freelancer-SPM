
CREATE TABLE [job_seeker] (
  [id] integer PRIMARY KEY,
  [account_id] integer,
  [bio] text
)
GO

CREATE TABLE [user_account] (
  [id] integer PRIMARY KEY,
  [email] varchar(50),
  [password] nvarchar(255),
  [contact_number] text,
  [user_image] varchar(50),
  [created_at] timestamp,
  [data_of_birth] varchar(50),
  [first_name] nvarchar(255),
  [last_name] nvarchar(255)
)
GO

CREATE TABLE [employer_profile] (
  [id] integer PRIMARY KEY,
  [is_company] char,
  [user_id] integer
)
GO

CREATE TABLE [job_description] (
  [id] integer PRIMARY KEY,
  [type] nvarchar(255),
  [name] text,
  [descr] text,
  [salary] integer
)
GO

CREATE TABLE [job_location] (
  [id] integer PRIMARY KEY,
  [country] nvarchar(255),
  [city] nvarchar(255),
  [street_adress] nvarchar(255)
)
GO

CREATE TABLE [job_post] (
  [id] integer PRIMARY KEY,
  [employer_profile_id] integer,
  [job_description_id] integer,
  [is_active] nvarchar(255),
  [created_at] timestamp,
  [job_location_id] integer
)
GO

CREATE TABLE [job_post_activity] (
  [id] integer PRIMARY KEY,
  [job_post_id] integer,
  [job_seeker_id] integer,
  [respones_at] date
)
GO

CREATE TABLE [seekers_skills] (
  [id] integer PRIMARY KEY,
  [skill_id] integer,
  [seeker_id] integer
)
GO

CREATE TABLE [job_posts_skills] (
  [id] integer PRIMARY KEY,
  [job_post_id] integer,
  [skill_id] integer
)
GO


CREATE TABLE [skills] (
  [id] integer PRIMARY KEY,
  [name] nvarchar(255)
)
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'online/hybrid/full_time',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'job_description',
@level2type = N'Column', @level2name = 'type';
GO

ALTER TABLE [job_seeker] ADD FOREIGN KEY ([account_id]) REFERENCES [user_account] ([id])
GO

ALTER TABLE [employer_profile] ADD FOREIGN KEY ([user_id]) REFERENCES [user_account] ([id])
GO

ALTER TABLE [job_post] ADD FOREIGN KEY ([employer_profile_id]) REFERENCES [employer_profile] ([id])
GO

ALTER TABLE [job_post] ADD FOREIGN KEY ([job_description_id]) REFERENCES [job_description] ([id])
GO

ALTER TABLE [job_post] ADD FOREIGN KEY ([job_location_id]) REFERENCES [job_location] ([id])
GO

ALTER TABLE [job_post_activity] ADD FOREIGN KEY ([job_post_id]) REFERENCES [job_post] ([id])
GO

ALTER TABLE [job_post_activity] ADD FOREIGN KEY ([job_seeker_id]) REFERENCES [job_seeker] ([id])
GO

ALTER TABLE [seekers_skills] ADD FOREIGN KEY ([skill_id]) REFERENCES [skills] ([id])
GO

ALTER TABLE [seekers_skills] ADD FOREIGN KEY ([seeker_id]) REFERENCES [job_seeker] ([id])
GO

ALTER TABLE [job_posts_skills] ADD FOREIGN KEY ([job_post_id]) REFERENCES [job_post] ([id])
GO

ALTER TABLE [job_posts_skills] ADD FOREIGN KEY ([skills]) REFERENCES [skills] ([id])
GO
INSERT INTO user_account VALUES(
  1,
  'fedkungurov@gmail.com',
  'slons',
  '1488',
  'user_image_example.jpg',
  DEFAULT,
  '123',
  'Sachuk',
  'Alex'
);
INSERT INTO user_account VALUES(
  2,
  'ururur@mail.ru',
  'slons',
  '1488',
  'user_image_example.jpg',
  DEFAULT,
  '123',
  'Fedor',
  'Kungruov'
);
GO
INSERT INTO skills VALUES (1, 'Java')
INSERT INTO skills VALUES (2, 'Shooting')
INSERT INTO skills VALUES (3, 'C++')
INSERT INTO skills VALUES (4, 'C')
INSERT INTO skills VALUES (5, 'Math')
INSERT INTO skills VALUES (6, 'Python')
INSERT INTO skills VALUES (7, 'SQL')

INSERT INTO employer_profile VALUES (1, '0', 1)
INSERT INTO job_seeker VALUES (1, 2, 'Java master')
INSERT INTO job_description VALUES(1, 'online', 'Java Backend', 'IDK', 10000)
INSERT INTO job_location VALUES (1,'Russia', 'Saint Petersurgh', 'Veteranov St.')
INSERT INTO job_post VALUES(1,1,1,'1',DEFAULT,1)
INSERT INTO job_posts_skills VALUES(1,1,1)
INSERT INTO job_posts_skills VALUES(2,1,7)

INSERT INTO seekers_skills VALUES(1, 1, 1)
INSERT INTO seekers_skills VALUES(2, 3, 1)
INSERT INTO seekers_skills VALUES(3, 4, 1)
INSERT INTO seekers_skills VALUES(4, 7, 1)



SELECT user_account.first_name, user_account.last_name 
FROM user_account WHERE user_account.id 
IN (SELECT job_seeker.account_id FROM job_seeker
WHERE job_seeker.id  IN  (SELECT seekers_skills.seeker_id
FROM seekers_skills WHERE seekers_skills.skill_id IN ((SELECT skill_id FROM job_posts_skills 
WHERE job_posts_skills.job_post_id = 1))))



