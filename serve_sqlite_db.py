"""

"""

import flask

app = flask.Flask(__name__)

#import endpoints.create_database
#import endpoints.create_schema
#import endpoints.create_table
#import endpoints.insert_into
import endpoints.query
# import endpoints.update_table

app = flask.Flask(__name__)

app.register_blueprint(endpoints.query.bp)



