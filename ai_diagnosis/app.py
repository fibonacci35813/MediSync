from taipy import Gui

#visualise elements
### markdown text

title = "This is a title"
page = """
# Taipy Crash Course

<|{title}|text|>

"""
if __name__ == "__main__":
    Gui(page).run(use_reloader=True,debug=True,port=5000)