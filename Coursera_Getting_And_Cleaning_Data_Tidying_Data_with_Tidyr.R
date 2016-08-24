library(tidyr)
#The author of tidyr, Hadley Wickham, discusses his philosophy of tidy data in his 'Tidy Data' paper:

#http://vita.had.co.nz/papers/tidy-data.pdf
#This paper should be required reading for anyone who works with data, but it's not required in order
#to complete this lesson.
#Tidy data is formatted in a standard way that facilitates exploration and analysis and works
#seamlessly with other tidy data tools. Specifically, tidy data satisfies three conditions:

#1) Each variable forms a column

#2) Each observation forms a row
#3) Each type of observational unit forms a table
#To tidy the students data, we need to have one column for each of these three variables. We'll use
#the gather() function from tidyr to accomplish this. Pull up the documentation for this function with
#?gather.
?gather
#Using the help file as a guide, call gather() with the following arguments (in order): students, sex,
#count, -grade. Note the minus sign before grade, which says we want to gather all columns EXCEPT
#grade.
gather(students,sex,count,-grade)
#It's important to understand what each argument to gather() means. The data argument, students, gives
#the name of the original dataset. The key and value arguments -- sex and count, respectively -- give
#the column names for our tidy dataset. The final argument, -grade, says that we want to gather all
#columns EXCEPT the grade column (since grade is already a proper column variable.)
res <- gather(students2,sex_class,count,-grade)
separate(data = res, col = sex_class, into = c("sex", "class"))
# Conveniently, separate() was able to figure out on its own how to separate the sex_class column.
# Unless you request otherwise with the 'sep' argument, it splits on non-alphanumeric values. In other
# words, it assumes that the values are separated by something other than a letter or number (in this
# case, an underscore.)
# Repeat your calls to gather() and separate(), but this time
# use the %>% operator to chain the commands together without
# storing an intermediate result.
#
# If this is your first time seeing the %>% operator, check
# out ?chain, which will bring up the relevant documentation.
# You can also look at the Examples section at the bottom
# of ?gather and ?separate.
#
# The main idea is that the result to the left of %>%
# takes the place of the first argument of the function to
# the right. Therefore, you OMIT THE FIRST ARGUMENT to each
# function.
#
students2 %>%
  gather(sex_class,count,-grade) %>%
  separate(col = sex_class, into = c("sex", "class")) %>%
  print
# Call gather() to gather the columns class1
# through class5 into a new variable called class.
# The 'key' should be class, and the 'value'
# should be grade.
#
# tidyr makes it easy to reference multiple adjacent
# columns with class1:class5, just like with sequences
# of numbers.
#
# Since each student is only enrolled in two of
# the five possible classes, there are lots of missing
# values (i.e. NAs). Use the argument na.rm = TRUE
# to omit these values from the final result.
#
# Remember that when you're using the %>% operator,
# the value to the left of it gets inserted as the
# first argument to the function on the right.
#
# Consult ?gather and/or ?chain if you get stuck.
#
students3 %>%
  gather( class, grade, class1:class5 ,na.rm = TRUE) %>%
  print
?spread
# This script builds on the previous one by appending
# a call to spread(), which will allow us to turn the
# values of the test column, midterm and final, into
# column headers (i.e. variables).
#
# You only need to specify two arguments to spread().
# Can you figure out what they are? (Hint: You don't
# have to specify the data argument since we're using
# the %>% operator.
#
students3 %>%
  gather(class, grade, class1:class5, na.rm = TRUE) %>%
  spread(test, grade) %>%
  print
extract_numeric("class5")
# We want the values in the class columns to be
# 1, 2, ..., 5 and not class1, class2, ..., class5.
#
# Use the mutate() function from dplyr along with
# extract_numeric(). Hint: You can "overwrite" a column
# with mutate() by assigning a new value to the existing
# column instead of creating a new column.
#
# Check out ?mutate and/or ?extract_numeric if you need
# a refresher.
#
students3 %>%
  gather(class, grade, class1:class5, na.rm = TRUE) %>%
  spread(test, grade) %>%
  mutate(class=extract_numeric(class))%>%
  print
# Add a call to unique() below, which will remove
# duplicate rows from student_info.
#
# Like with the call to the print() function below,
# you can omit the parentheses after the function name.
# This is a nice feature of %>% that applies when
# there are no additional arguments to specify.
#
student_info <- students4 %>%
  select(id, name, sex) %>%
  unique()%>%
  print
passed <- passed %>% mutate(status = "passed")
failed <- failed %>% mutate(status = "failed")
bind_rows(passed,failed)



# Append two more function calls to accomplish the following:
#
# 1. Use group_by() (from dplyr) to group the data by part and
# sex, in that order.
#
# 2. Use mutate to add two new columns, whose values will be
# automatically computed group-by-group:
#
#   * total = sum(count)
#   * prop = count / total
#
sat %>%
  select(-contains("total")) %>%
  gather(part_sex, count, -score_range) %>%
  separate(part_sex, c("part", "sex")) %>%
  group_by(part,sex)%>%
  mutate(total = sum(count),
         prop = count / total
  ) %>% print
