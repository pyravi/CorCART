import os
import dialogflow
from django.views.decorators.csrf import csrf_exempt
from django.http import HttpResponse
from django.views.decorators.http import require_http_methods

@csrf_exempt
def chat_view(request):
    GOOGLE_AUTHENTICATION_FILE_NAME = "AppointmentScheduler.json"
    current_directory = os.path.dirname(os.path.realpath(__file__))
    path = os.path.join(current_directory, GOOGLE_AUTHENTICATION_FILE_NAME)
    os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = path
    GOOGLE_PROJECT_ID = "vmart-mpvfgt"
    session_id = "1234567891"
    context_short_name = "does_not_matter"
    context_name = "projects/" + GOOGLE_PROJECT_ID + "/agent/sessions/" + session_id + "/contexts/" +  context_short_name.lower()
    parameters = dialogflow.types.struct_pb2.Struct()
    parameters["foo"] = "bar"
    context_1 = dialogflow.types.context_pb2.Context(
        name=context_name,
        lifespan_count=2,
        parameters=parameters
    )
    query_params_1 = {"contexts": [context_1]}
    language_code = 'en'

    # response = detect_intent_with_parameters(
    #     project_id=GOOGLE_PROJECT_ID,
    #     session_id=session_id,
    #     query_params=query_params_1,
    #     language_code=language_code,
    #     user_input=input_text
    # )
    session_client = dialogflow.SessionsClient()
    session = session_client.session_path(project_id, session_id)
    print('Session path: {}\n'.format(session))
    text = "this is as test"
    text_input = dialogflow.types.TextInput(text=text, language_code=language_code)
    query_input = dialogflow.types.QueryInput(text=text_input)
    response = session_client.detect_intent(session=session, query_input=query_input, query_params=query_params)
    print('=' * 20)
    print('Query text: {}'.format(response.query_result.query_text))
    print('Detected intent: {} (confidence: {})\n'.format(response.query_result.intent.display_name,response.query_result.intent_detection_confidence))
    print('Fulfillment text: {}\n'.format(response.query_result.fulfillment_text))
    print(response.query_result.fulfillment_text, status=200)
    print(response)
    return HttpResponse(response)


request='POST'
chat_view(request)
