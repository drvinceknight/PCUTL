#! /usr/bin/env sage
'''
Code to analyse data from first 4 weeks of MAT001. Variables are:

0. Timestamp
1. Student_Number
2. Learner_Type
3. Ease_of_Access
4. Ease_of_Reading
5. Watch_Prior
6. Watch_Post
7. Sage_Lab
8. Sage_Home
9. Gplus_Look
10. Comments_re_Delivery
11. Troublesome_Parts
12. Comments_re_Troublesome
13. Motivating_Parts
14. Comments_re_Motivating
15. AoB
'''
import csv


def dict_percent(d):
    if 'True' not in d:
        d['True']=0
    return d['True']/sum(d.values())

class Student():
    def __init__(self, Student_Number, Learner_Type, Ease_of_Access, Ease_of_Reading, Watch_Prior, Watch_Post, Sage_Lab, Sage_Home, Gplus_Look, Comments_re_Delivery, Troublesome_Parts, Comments_re_Troublesome, Motivating_Parts, Comments_re_Motivating, AoB):
        self.Student_Number = Student_Number
        self.Learner_Type = Learner_Type
        self.Ease_of_Access = Ease_of_Access
        self.Ease_of_Reading = Ease_of_Reading
        self.Watch_Prior = Watch_Prior
        self.Watch_Post = Watch_Post
        self.Sage_Lab = Sage_Lab
        self.Sage_Home = Sage_Home
        self.Gplus_Look = Gplus_Look
        self.Comments_re_Delivery = Comments_re_Delivery
        self.Troublesome_Parts = Troublesome_Parts
        self.Comments_re_Troublesome = Comments_re_Troublesome
        self.Motivating_Parts = Motivating_Parts
        self.Comments_re_Motivating = Comments_re_Motivating
        self.AoB = AoB


def add_comment_to_file(file, string):
    if string != "":
        f = open(file, "ab")
        f.write("\n")
        f.write("---")
        f.write("\n")
        f.write("%s \n" % string)
        f.write("\n")
        f.close()


def display_string(string):
    print (len(string) + 4) * "-"
    print "|", " " * len(string), "|"
    print "|", string, "|"
    print "|", " " * len(string), "|"
    print (len(string) + 4) * "-"


def data_eval(string):
    try:
        return eval(string)
    except:
        if string == 'Yes':
            string = True
        if string == 'No':
            string = False
        return string


def dict_increment(dict, string):
    if string == "":
        string = "No Response"
    if string in dict:
        dict[string] += 1
    else:
        dict[string] = 1


Ease_of_Access_Dict = {}
Ease_of_Reading_Dict = {}
Watch_Prior_Dict = {}
Watch_Post_Dict = {}
Sage_Lab_Dict = {}
Sage_Home_Dict = {}
Gplus_Look_Dict = {}
Troublesome_Parts_Dict = {}
Motivating_Parts_Dict = {}
data_for_chi_squared = [["Group", "Ease_of_Access_Y", "Ease_of_Access_N", "Ease_of_Reading_Y", "Ease_of_Reading_N", "Watch_Prior_Y", "Watch_Prior_N", "Watch_Post_Y", "Watch_Prior_N", "Sage_Lab_Y", "Sage_Lab_N", "Sage_Home_Y", "Sage_Home_N", "G_Plus_Look_Y", "G_Plus_Look_N"]]


def chi_squared_data(Ease_of_Access_Dict, Ease_of_Reading_Dict, Watch_Prior_Dict, Watch_Post_Dict, Sage_Lab_Dict, Sage_Home_Dict, Gplus_Look_Dict, Group):
    dict_list = [Ease_of_Access_Dict, Ease_of_Reading_Dict, Watch_Prior_Dict, Watch_Post_Dict, Sage_Lab_Dict, Sage_Home_Dict, Gplus_Look_Dict]
    for e in dict_list:
        if 'True' not in e:
            e['True'] = 0
        if 'False' not in e:
            e['False'] = 0
    temp = [Group, Ease_of_Access_Dict['True'], Ease_of_Access_Dict['False'], Ease_of_Reading_Dict['True'], Ease_of_Reading_Dict['False'], Watch_Prior_Dict['True'], Watch_Prior_Dict['False'], Watch_Post_Dict['True'], Watch_Post_Dict['False'], Sage_Lab_Dict['True'], Sage_Lab_Dict['False'], Sage_Home_Dict['True'], Sage_Home_Dict['False'], Gplus_Look_Dict['True'], Gplus_Look_Dict['False']]
    data_for_chi_squared.append(temp)


outfile = open("Feedback_for_Weeks_1_to_4_of_MAT001.csv", 'rb')
raw_data = csv.reader(outfile)
raw_data = [row for row in raw_data]
outfile.close()
raw_data = [[data_eval(e) for e in row] for row in raw_data]

N = len(raw_data)
nbr_of_variables = len(raw_data[0])

string = "Data read in with %s students and %s variables" % (N, nbr_of_variables)
display_string(string)

Students = []

for row in raw_data[1:]:
    Students.append(Student(row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8], row[9], row[10], row[11], row[12], row[13], row[14], row[15]))

Learner_Types = {}
Ease_of_Access_Dict = {}
Ease_of_Reading_Dict = {}
Watch_Prior_Dict = {}
Watch_Post_Dict = {}
Sage_Lab_Dict = {}
Sage_Home_Dict = {}
Gplus_Look_Dict = {}
Troublesome_Parts_Dict = {}
Motivating_Parts_Dict = {}

f = open("Delivery_Comments.md", "wb")
f.write("##Delivery\n")
f.close()
f = open("Troublesome_Parts_Comments.md", "wb")
f.write("##Troublesome Parts\n")
f.close()
f = open("Motivating_Parts_Comments.md", "wb")
f.write("##Motivating Parts\n")
f.close()
f = open("AoB.md", "wb")
f.write("##AoB\n")
f.close()

for student in Students:
    if student.Learner_Type != "":
        lt = student.Learner_Type.split()[0]
    else:
        lt = "No response"
    student.Learner_Type = lt

    dict_increment(Learner_Types, lt)
    dict_increment(Ease_of_Access_Dict, "%s" % student.Ease_of_Access)
    dict_increment(Ease_of_Reading_Dict, "%s" % student.Ease_of_Reading)
    dict_increment(Watch_Prior_Dict, "%s" % student.Watch_Prior)
    dict_increment(Watch_Post_Dict, "%s" % student.Watch_Post)
    dict_increment(Sage_Lab_Dict, "%s" % student.Sage_Lab)
    dict_increment(Sage_Home_Dict, "%s" % student.Sage_Home)
    dict_increment(Gplus_Look_Dict, "%s" % student.Gplus_Look)
    for e in student.Troublesome_Parts.split(", "):
        dict_increment(Troublesome_Parts_Dict, e.lstrip())
    for e in student.Motivating_Parts.split(", "):
        dict_increment(Motivating_Parts_Dict, e.lstrip())

    #Write Markdown file with comments from students about delivery:
    add_comment_to_file("Delivery_Comments.md", student.Comments_re_Delivery)

    #Write Markdown file with comments from students about troublesome aspects:
    add_comment_to_file("Troublesome_Parts_Comments.md", student.Comments_re_Troublesome)

    #Write Markdown file with comments from students about motivating aspects:
    add_comment_to_file("Motivating_Parts_Comments.md", student.AoB)

    #Write Markdown file with AoB comments:
    add_comment_to_file("AoB.md", student.AoB)

p = list_plot([[0, 0]], size=0)
k = 0
colors = rainbow(len(Learner_Types))
for e in Learner_Types:
    k += 1
    p += list_plot([[k, Learner_Types[e]]], legend_label="%s: " % k + e, color=colors[k - 1], size=30)
p.set_legend_options(loc=(.1, .8))
p.save("Learner_Type_Plot.png")

print "Learner_Types: ", Learner_Types
print "Ease_of_Access: ", Ease_of_Access_Dict
print "\t%s answered affirmatively" % dict_percent(Ease_of_Access_Dict)
print "Ease_of_Reading: ", Ease_of_Reading_Dict
print "\t%s answered affirmatively" % dict_percent(Ease_of_Reading_Dict)
print "Watch_Prior: ", Watch_Prior_Dict
print "\t%s answered affirmatively" % dict_percent(Watch_Prior_Dict)
print "Watch_Post: ", Watch_Post_Dict
print "\t%s answered affirmatively" % dict_percent(Watch_Post_Dict)
print "Sage_Lab: ", Sage_Lab_Dict
print "\t%s answered affirmatively" % dict_percent(Sage_Lab_Dict)
print "Sage_Home: ", Sage_Home_Dict
print "\t%s answered affirmatively" % dict_percent(Sage_Home_Dict)
print "Gplus_Look: ", Gplus_Look_Dict
print "\t%s answered affirmatively" % dict_percent(Gplus_Look_Dict)
print "Troublesome_Parts: ", Troublesome_Parts_Dict
print "Motivating_Parts: ", Motivating_Parts_Dict
chi_squared_data(Ease_of_Access_Dict, Ease_of_Reading_Dict, Watch_Prior_Dict, Watch_Post_Dict, Sage_Lab_Dict, Sage_Home_Dict, Gplus_Look_Dict, "Total")

print "\n\n"

for e in Learner_Types:
    print "Particular work on learner type:", e
    Students_Considered = [s for s in Students if s.Learner_Type == e]

    Ease_of_Access_Dict = {}
    Ease_of_Reading_Dict = {}
    Watch_Prior_Dict = {}
    Watch_Post_Dict = {}
    Sage_Lab_Dict = {}
    Sage_Home_Dict = {}
    Troublesome_Parts_Dict = {}
    Motivating_Parts_Dict = {}
    Gplus_Look_Dict = {}

    for student in Students_Considered:
        dict_increment(Ease_of_Access_Dict, "%s" % student.Ease_of_Access)
        dict_increment(Ease_of_Reading_Dict, "%s" % student.Ease_of_Reading)
        dict_increment(Watch_Prior_Dict, "%s" % student.Watch_Prior)
        dict_increment(Watch_Post_Dict, "%s" % student.Watch_Post)
        dict_increment(Sage_Lab_Dict, "%s" % student.Sage_Lab)
        dict_increment(Sage_Home_Dict, "%s" % student.Sage_Home)
        dict_increment(Gplus_Look_Dict, "%s" % student.Gplus_Look)
        for k in student.Troublesome_Parts.split(", "):
            dict_increment(Troublesome_Parts_Dict, k.lstrip())
        for k in student.Motivating_Parts.split(", "):
            dict_increment(Motivating_Parts_Dict, k.lstrip())

    print "Ease_of_Access: ", Ease_of_Access_Dict
    print "\t%s answered affirmatively" % dict_percent(Ease_of_Access_Dict)
    print "Ease_of_Reading: ", Ease_of_Reading_Dict
    print "\t%s answered affirmatively" % dict_percent(Ease_of_Reading_Dict)
    print "Watch_Prior: ", Watch_Prior_Dict
    print "\t%s answered affirmatively" % dict_percent(Watch_Prior_Dict)
    print "Watch_Post: ", Watch_Post_Dict
    print "\t%s answered affirmatively" % dict_percent(Watch_Post_Dict)
    print "Sage_Lab: ", Sage_Lab_Dict
    print "\t%s answered affirmatively" % dict_percent(Sage_Lab_Dict)
    print "Sage_Home: ", Sage_Home_Dict
    print "\t%s answered affirmatively" % dict_percent(Sage_Home_Dict)
    print "Gplus_Look: ", Gplus_Look_Dict
    print "\t%s answered affirmatively" % dict_percent(Gplus_Look_Dict)
    print "Troublesome_Parts: ", Troublesome_Parts_Dict
    print "Motivating_Parts: ", Motivating_Parts_Dict
    chi_squared_data(Ease_of_Access_Dict, Ease_of_Reading_Dict, Watch_Prior_Dict, Watch_Post_Dict, Sage_Lab_Dict, Sage_Home_Dict, Gplus_Look_Dict, e)
    print "\n\n"

#file = open("Data_for_R.csv", "wb")
#outfile = csv.writer(file)
#
#for e in data_for_chi_squared:
#    outfile.writerow(e)
#file.close()
